FROM doublemine/ss-libev
RUN set -ex && \
  apk add --no-cache rng-tools  \
  nodejs \
  nodejs-npm \
  python   && \
  npm install -g shadowsocks-manager --unsafe &&\
  npm install -g pm2 && \
  npm cache clean -f


COPY hybrid/ss.yml.template /root/ss.yml.template
VOLUME  /root/.ssmgr


COPY hybrid/entrypoint /
ENTRYPOINT ["/entrypoint"]
