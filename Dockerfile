FROM oven/bun:1.4.4 AS bun

FROM mcr.microsoft.com/playwright:v1.64.1-resolute

COPY --from=bun /usr/local/bin/bun /usr/local/bin/bun

ARG USERNAME=test
ARG UID=10001
ARG GID=10001

RUN \
  groupadd --gid ${GID} ${USERNAME} && \
  useradd --uid ${UID} --gid ${GID} --no-create-home --shell /usr/sbin/nologin ${USERNAME} && \
  install -d -o ${UID} -g ${GID} /app /app/data /app/secrets

WORKDIR /app

ENV NODE_ENV=production

COPY --chown=${UID}:${GID} package.json bun.lock ./

USER ${USERNAME}

RUN bun install --frozen-lockfile

COPY --chown=${UID}:${GID} . .
