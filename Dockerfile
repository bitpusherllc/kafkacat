FROM debian:stretch-slim

COPY . /usr/src/kafkacat

RUN set -ex; \
  buildDeps='curl ca-certificates build-essential zlib1g-dev python cmake'; \
  export DEBIAN_FRONTEND=noninteractive; \
  apt-get update && apt-get install -y $buildDeps --no-install-recommends; \
  rm -rf /var/lib/apt/lists/*; \
  \
  cd /usr/src/kafkacat; \
  echo "Source versions:"; \
  cat ./bootstrap.sh | grep github_download; \
  ./bootstrap.sh; \
  mv ./kafkacat /usr/local/bin/; \
  \
  rm -rf /usr/src/kafkacat/tmp-bootstrap; \
  apt-get purge -y --auto-remove $buildDeps; \
  rm /var/log/dpkg.log /var/log/alternatives.log /var/log/apt/*.log

ENTRYPOINT ["kafkacat"]
