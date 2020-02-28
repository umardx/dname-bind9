FROM debian:10-slim

RUN apt-get update && apt install bind9 bind9utils -y \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

COPY data/bind/ /etc/bind/

EXPOSE 53

CMD ["named", "-c", "/etc/bind/named.conf", "-g", "-u", "bind"]