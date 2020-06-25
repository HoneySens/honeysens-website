FROM alpine:3.11

RUN set -ex; \
    apk --no-cache add hugo

WORKDIR /mnt
CMD ["hugo", "server", "-D", "--bind", "0.0.0.0"]
