FROM alpine:3.7
RUN set -ex && \
  apk add --no-cache rng-tools  \
  nodejs \
  nodejs-npm \
  python   && \
  npm install -g shadowsocks-manager --unsafe &&\
  npm cache clean -f

VOLUME  /root/.ssmgr
