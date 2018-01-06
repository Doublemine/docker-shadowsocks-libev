FROM alpine:3.6
RUN set -ex && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories &&\
    apk add --no-cache --virtual .build-deps \
                                autoconf \
                                build-base \
                                git \
                                libev-dev \
                                libtool \
                                linux-headers \
                                libsodium-dev \
                                mbedtls-dev \
                                pcre-dev \
                                tar \
                                c-ares-dev  \
                                openssl-dev \
                                udns-dev \
                                automake \
                                asciidoc \
                                xmlto && \
   cd /tmp && \
   git clone https://github.com/shadowsocks/shadowsocks-libev.git && \
   cd shadowsocks-libev && \
   git submodule update --init --recursive && \
   ./autogen.sh && \
   ./configure --prefix=/usr --disable-documentation && \
   make install && \
   cd .. && \
   git clone https://github.com/shadowsocks/simple-obfs.git && \
   cd simple-obfs && \
   git submodule update --init --recursive && \
   ./autogen.sh && \
   ./configure && make && \
   make install && \
   cd .. && \


   runDeps="$( \
    scanelf --needed --nobanner /usr/bin/ss-* \
        | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
        | xargs -r apk info --installed \
        | sort -u \
  )" && \
  apk add --no-cache --virtual .run-deps $runDeps && \
  apk del .build-deps && \
  rm -rf /tmp/*  && \
  apk add --no-cache rng-tools  \
  nodejs \
  python \
  nodejs-npm && \
  npm install -g shadowsocks-manager &&\
  npm install -g pm2 && \
  npm cache clean -f

ONBUILD COPY ss.yml /root/ss.yml

COPY entrypoint /
ENTRYPOINT ["/entrypoint"]
