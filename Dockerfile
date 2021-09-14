FROM alpine:3.10

RUN apk add --no-cache bash

RUN wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz && \
tar xf kubeval-linux-amd64.tar.gz && \
cp kubeval /usr/local/bin

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
