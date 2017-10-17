FROM alpine
RUN set -ex && \
  apk add --no-cache rng-tools  \
  nodejs \
  nodejs-npm && \
  npm install -g shadowsocks-manager &&\
  npm cache clean -f

VOLUME  /root/.ssmgr

ENTRYPOINT ["/usr/bin/ssmgr"]
