# /bin/bash

# form gist https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
get_latest_release() {
    curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

export VERSION_SHADOWSOCKS_LIBEV=$(get_latest_release shadowsocks/shadowsocks-libev)
export VERSION_V2RAY_PLUGIN=$(get_latest_release shadowsocks/v2ray-plugin)

docker build -t $DOCKER_USERNAME/shadowsocks-libev:$VERSION_SHADOWSOCKS_LIBEV -f shadowsocks/Dockerfile .
docker build -t $DOCKER_USERNAME/shadowsocks-manager:$VERSION_V2RAY_PLUGIN -f shadowsocks-manager/Dockerfile .

docker push $DOCKER_USERNAME/shadowsocks-libev:$VERSION_SHADOWSOCKS_LIBEV
docker tag $DOCKER_USERNAME/shadowsocks-libev:$VERSION_SHADOWSOCKS_LIBEV $DOCKER_USERNAME/shadowsocks-libev:latest
docker push $DOCKER_USERNAME/shadowsocks-libev:latest

docker push $DOCKER_USERNAME/shadowsocks-manager:$VERSION_V2RAY_PLUGIN
docker tag $DOCKER_USERNAME/shadowsocks-manager:$VERSION_V2RAY_PLUGIN $DOCKER_USERNAME/shadowsocks-manager:latest
docker push $DOCKER_USERNAME/shadowsocks-manager:$VERSION_V2RAY_PLUGIN
