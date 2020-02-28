FROM debian:10-slim

COPY entrypoint.sh /entrypoint.sh

RUN apt-get update && apt install dnsutils bind9 bind9utils -y \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives \
    && chmod +x /entrypoint.sh \
    && mkdir -p /etc/bind /var/bind /var/run/named /var/bind/dyn /var/bind/pri /var/bind/sec \
    && chown -R bind:bind /etc/bind /var/bind /var/run/named

EXPOSE 53 53/udp

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/named","-c","/etc/bind/named.conf","-f","-u","bind","-g","-4"]
