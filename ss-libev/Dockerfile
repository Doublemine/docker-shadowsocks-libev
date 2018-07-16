FROM alpine:3.7
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
                                rng-tools \
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
  rm -rf /tmp/*  
