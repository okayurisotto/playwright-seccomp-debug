echo 1. Docker without - /bin/true
(cd seccomp && ./use-docker.sh            ) && docker compose -f compose.without-security_opt.yaml run --rm --entrypoint '/bin/true'        test

echo 2. Docker without - bun run index.ts
(cd seccomp && ./use-docker.sh            ) && docker compose -f compose.without-security_opt.yaml run --rm --entrypoint 'bun run index.ts' test

echo 3. Docker with - /bin/true
(cd seccomp && ./use-docker.sh            ) && docker compose -f compose.with-security_opt.yaml    run --rm --entrypoint '/bin/true'        test

echo 4. Docker with - bun run index.ts
(cd seccomp && ./use-docker.sh            ) && docker compose -f compose.with-security_opt.yaml    run --rm --entrypoint 'bun run index.ts' test

echo 5. Patched Docker without - /bin/true
(cd seccomp && ./use-patched-docker.sh    ) && docker compose -f compose.without-security_opt.yaml run --rm --entrypoint '/bin/true'        test

echo 6. Patched Docker without - bun run index.ts
(cd seccomp && ./use-patched-docker.sh    ) && docker compose -f compose.without-security_opt.yaml run --rm --entrypoint 'bun run index.ts' test

echo 7. Patched Docker with - /bin/true
(cd seccomp && ./use-patched-docker.sh    ) && docker compose -f compose.with-security_opt.yaml    run --rm --entrypoint '/bin/true'        test

echo 8. Patched Docker with - bun run index.ts
(cd seccomp && ./use-patched-docker.sh    ) && docker compose -f compose.with-security_opt.yaml    run --rm --entrypoint 'bun run index.ts' test

echo 9. Playwright without - /bin/true
(cd seccomp && ./use-playwright.sh        ) && docker compose -f compose.without-security_opt.yaml run --rm --entrypoint '/bin/true'        test

echo 10. Playwright without - bun run index.ts
(cd seccomp && ./use-playwright.sh        ) && docker compose -f compose.without-security_opt.yaml run --rm --entrypoint 'bun run index.ts' test

echo 11. Playwright with - /bin/true
(cd seccomp && ./use-playwright.sh        ) && docker compose -f compose.with-security_opt.yaml    run --rm --entrypoint '/bin/true'        test

echo 12. Playwright with - bun run index.ts
(cd seccomp && ./use-playwright.sh        ) && docker compose -f compose.with-security_opt.yaml    run --rm --entrypoint 'bun run index.ts' test

echo 13. Patched Playwright without - /bin/true
(cd seccomp && ./use-patched-playwright.sh) && docker compose -f compose.without-security_opt.yaml run --rm --entrypoint '/bin/true'        test

echo 14. Patched Playwright without - bun run index.ts
(cd seccomp && ./use-patched-playwright.sh) && docker compose -f compose.without-security_opt.yaml run --rm --entrypoint 'bun run index.ts' test

echo 15. Patched Playwright with - /bin/true
(cd seccomp && ./use-patched-playwright.sh) && docker compose -f compose.with-security_opt.yaml    run --rm --entrypoint '/bin/true'        test

echo 16. Patched Playwright with - bun run index.ts
(cd seccomp && ./use-patched-playwright.sh) && docker compose -f compose.with-security_opt.yaml    run --rm --entrypoint 'bun run index.ts' test
