[ -s default.json ] && rm default.json
patch --input playwright.patch --output default.json playwright.json
