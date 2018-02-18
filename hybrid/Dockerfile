FROM doublemine/ss-libev
RUN set -ex && \
  apk add --no-cache rng-tools  \
  nodejs \
  nodejs-npm && \
  npm install -g shadowsocks-manager &&\
  npm cache clean -f
COPY ss.yml.template /root/ss.yml.template
VOLUME  /root/.ssmgr
