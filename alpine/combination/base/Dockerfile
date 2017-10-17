FROM alpine
RUN set -ex && \
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
  nodejs-npm && \
  npm install -g shadowsocks-manager &&\
  npm install -g pm2 && \
  npm cache clean -f
  
 ONBUILD COPY ss.yml /root/ss.yml
 ONBUILD RUN pm2 --name "ssmgr" -f start ssmgr -x -- -c /root/ss.yml
 CMD ss-manager -m aes-256-gcm -t 3600 --fast-open -u -d 8.8.8.8 -d 8.8.4.4 -v --manager-address 127.0.0.1:4000  --plugin obfs-server --plugin-opts "obfs=tls"