#### docker image mirror


This is the shadowsocks-libev with simple-obfs docker image. It's based on alpine.















```bash
curl -sSL https://raw.githubusercontent.com/Doublemine/docker-shadowsocks-libev/master/set_mirror.sh | sh -s https://registry.docker-cn.com
```
or

```bash
curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s https://registry.docker-cn.com
```

This is the shadowsocks-libev with simple-obfs docker image. It's based on alpine and only 5MB.


#### Supported tags 

 - `latest`

```bash
docker pull doublemine/shadowsocks
```

 - `ssmgr`

```bash
docker pull doublemine/shadowsocks:ssmgr
```

 - `all`

```bash
docker pull doublemine/shadowsocks:all
```

 - `base`

```bash
docker pull doublemine/shadowsocks:base
```

#### Different

There are some different about each tag

 - `latest`


This image include latest shaodwsocks-libev

 - `ssmgr`


This image include latest shadowsocks-manager


 - `all`

This image include latest shaodwsocks-libev shadowsocks-manager simple-obfs


 - `base`

This image include latest shaodwsocks-libev shadowsocks-manager simple-obfs

#### Usage


There are some demo about different image：

##### doublemine/shadowsocks:base


step 1:

create a file named `ss.yml`,the content just like below:

```yml
type: s

shadowsocks:
  address: 127.0.0.1:6001
manager:
  address: 0.0.0.0:4001
  password: '123456'
db: 'ss.sqlite'
```

step 2:

create `Dockerfile` and the content just one line:

```dockerfile
FROM doublemine/shadowsocks:base
```

step 3:

run command to build local image:

```bash
docker build -t ss-server .
```

finally:

now you can run `shadowsocks-libev` `simple-obfs` `shadowsocks-manager` on `ss-server` image:

```
docker run --name ss-server -d --net=host --restart=always ss-server -m aes-128-gcm -t 600 -u  -p 6001 —fast-open —obfs http —dns1 8.8.8.8 —dns2 8.8.4.4
```
