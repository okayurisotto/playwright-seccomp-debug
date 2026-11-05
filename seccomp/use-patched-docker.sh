[ -s default.json ] && rm default.json
patch --input docker.patch --output default.json docker.json
