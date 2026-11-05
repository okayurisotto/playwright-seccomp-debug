curl -fsSL -o playwright.json \
  https://raw.githubusercontent.com/microsoft/playwright/refs/tags/v1.64.1/utils/docker/seccomp_profile.json

curl -fsSL -o docker.json \
  https://raw.githubusercontent.com/moby/profiles/refs/tags/seccomp/v0.3.0/seccomp/default.json
