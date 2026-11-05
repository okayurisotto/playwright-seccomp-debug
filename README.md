# playwright-seccomp-debug

## 概要

Playwrightは、Webテストおよび自動化のためのフレームワークです。WebアプリのEnd-to-Endなテストのために使われるほか、AIをはじめとする自動化システムにWebブラウザを操作させる際にも使われます。[公式ドキュメント](https://github.com/microsoft/playwright/blob/v1.64.1/docs/src/docker.md#crawling-and-scraping)では、Playwrightを使ってクローリング・スクレイピングを行うシステムをDockerを使って構築する場合、独自のseccompプロファイルを読み込ませることを推奨しています。これは、Chromiumブラウザのサンドボックスを有効化するためには、一部のシステムコールをseccompプロファイルに追加し、許可しなければならないためです。（信頼できないWebサイトの読み込みでは、サンドボックス機能はぜひとも有効化したいものです。）

そしてそのような独自のseccompプロファイルとして、次のように述べ、Playwrightがメンテナンスするものを使うように促しています。

> [`seccomp_profile.json`](https://github.com/microsoft/playwright/blob/main/utils/docker/seccomp_profile.json) is needed to run Chromium with sandbox. 

しかしながら、このseccompプロファイルは2020年7月の[PR #3077](https://github.com/microsoft/playwright/pull/3077)で追加されて以降、一度も更新されていません。そのためか、このseccompプロファイルを使ってDockerコンテナを起動することは、私の環境では不可能でした。以下のコマンドは、セグメンテーション違反（`SIGSEGV`）で失敗しました。

```sh
docker container run --rm --security-opt seccomp=seccomp_profile.json alpine echo ok
```

よって、私は、最新のDockerのデフォルトのseccompプロファイルをベースに、`syscalls`の配列に以下の内容を追加したものを使用することを推奨します。

```json
{
  "comment": "Allow create user namespaces",
  "names": [
    "clone",
    "setns",
    "unshare"
  ],
  "action": "SCMP_ACT_ALLOW"
}
```

（なお、起動されたChromiumがサンドボックス機能を使えているのかどうか確認するには、実際に`chromiumSandbox: true`で起動した際にエラーが出るかどうか調べることが有効です。）

このリポジトリは、この問題の検証のために使ったファイルを保存・公開するものです。検証のための試行錯誤がファイルとして残されています。詳しいログについては、`script -- bash ./test.sh`を実行してありますので、`typescript`ファイルを参照してください。

```
playwright-seccomp-debug
├── README.md
├── Dockerfile
├── compose.with-security_opt.yaml
├── compose.without-security_opt.yaml
├── package.json
├── bun.lock
├── index.ts - 検証用にPlaywrightを起動するスクリプト（結局問題の原因はもっと前の段階にあった）
├── seccomp
│   ├── init.sh
│   ├── docker.json     - init.shによってダウンロードされた、最新のDockerのデフォルトのseccompプロファイル
│   ├── playwright.json - init.shによってダウンロードされた、Playwrightのリポジトリにあるseccompプロファイル
│   ├── docker.patch     - サンドボックス機能のために許可リストへ追加する必要があるシステムコールを追加するパッチ
│   ├── playwright.patch - AIが「この値を追加して検証して」とお願いしてきたので書いたパッチ（結局問題の原因はもっと根本的なところにあった）
│   ├── use-docker.sh             - テストファイルから使われる
│   ├── use-playwright.sh         - テストファイルから使われる
│   ├── use-patched-docker.sh     - テストファイルから使われる
│   └── use-patched-playwright.sh - テストファイルから使われる
├── test.sh    - テストファイル
└── typescript - テストの結果
```

## 環境（別にこの環境が悪いわけではなかった）

```
$ uname -a
Linux shari 7.2.14-zen1-1-zen #1 ZEN SMP PREEMPT_DYNAMIC Fri, 30 Oct 2026 14:32:44 +0000 x86_64 GNU/Linux
```

```
$ runc --version
runc version 1.5.2
spec: 1.3.0
go: go1.27.1-X:nodwarf5
libseccomp: 2.6.0
libpathrs: 0.2.6
```

```
$ docker version
Client:
 Version:           29.9.2
 API version:       1.56
 Go version:        go1.27.3-X:nodwarf5
 Git commit:        a82e528901
 Built:             Tue Oct 20 23:42:57 2026
 OS/Arch:           linux/amd64
 Context:           default

Server:
 Engine:
  Version:          29.9.2
  API version:      1.56 (minimum version 1.40)
  Go version:       go1.27.3-X:nodwarf5
  Git commit:       0367cbeb49
  Built:            Tue Oct 20 23:42:57 2026
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          v2.4.2
  GitCommit:        b7a25261e029d68978bbf290df0a62fc819b3c51.m
 runc:
  Version:          1.5.2
  GitCommit:        
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

```
$ docker info --format '{{json .SecurityOptions}}'
["name=seccomp,profile=builtin","name=cgroupns"]
```

```
$ bun -v
1.4.4
```
