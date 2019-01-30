FROM golang:alpine as v2ray-plugin-builder
RUN set -ex \
    && apk add --no-cache git \
    && go get -v github.com/shadowsocks/v2ray-plugin 
# build
RUN set -ex \
    && cd  /go/src/github.com/shadowsocks/v2ray-plugin \
    && go build


FROM alpine:3.8
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
    runDeps="$( \
    scanelf --needed --nobanner /usr/bin/ss-* \
    | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
    | xargs -r apk info --installed \
    | sort -u \
    )" && \
    apk add --no-cache --virtual .run-deps $runDeps && \
    apk del .build-deps && \
    rm -rf /tmp/*  
COPY --from=v2ray-plugin-builder /go/src/github.com/shadowsocks/v2ray-plugin/v2ray-plugin /usr/bin/v2ray-plugin