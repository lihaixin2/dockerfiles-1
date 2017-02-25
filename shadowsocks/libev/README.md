![](https://img.shields.io/badge/shadowsocks--libev-3.0.3-brightgreen.svg) ![](https://img.shields.io/badge/Alpine-3.5-brightgreen.svg) ![](https://img.shields.io/docker/stars/gists/shadowsocks-libev.svg) ![](https://img.shields.io/docker/pulls/gists/shadowsocks-libev.svg)

#### Environment:

| Environment | Default value |
|-------------|---------------|
| SERVER_ADDR | 0.0.0.0       |
| SERVER_PORT | 8388          |
| PASSWORD    | $(hostname)   |
| METHOD      | rc4-md5       |
| TIMEOUT     | 300           |
| DNS_ADDR    | 8.8.8.8       |
| DNS_ADDR_2  | 8.8.4.4       |

#### Creating an instance:

    docker run \
        -d \
        --name shadowsocks \
        -p 8388:8388 \
        -e PASSWORD=password \
        -e METHOD=chacha20-ietf-poly1305
        gists/shadowsocks-libev

#### Compose example:

    shadowsocks:
      image: gists/shadowsocks-libev
      ports:
        - "8388:8388/tcp"
      environment:
        - PASSWORD=password
        - METHOD=chacha20-ietf-poly1305
      restart: always

#### Over simple-obfs:

    version: '2'

    services:
        ss:
            container_name: ss
            image: gists/shadowsocks-libev
            environment:
              - PASSWORD=password
              - METHOD=chacha20-ietf-poly1305
            restart: always
        obfs:
            container_name: obfs
            image: gists/simple-obfs
            ports:
              - "8443:8443/tcp"
            environment:
              - SERVER_PORT=8443
              - REMOTE_SERVER=ss:8388
            links:
              - ss
            restart: always