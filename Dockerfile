FROM debian:buster-slim
LABEL maintainer=roninkenji

RUN mkdir -p /dropbox
WORKDIR /dropbox
EXPOSE 17500
EXPOSE 17500/udp

RUN apt update && apt install -y \
    python3 \
    qt5dxcb-plugin \
    wget

RUN wget -nv -O- https://www.dropbox.com/download?plat=lnx.x86_64 | tar -C /usr/local -zx && chown -Rv root:root /usr/local/.dropbox-dist

ADD dockerinit.sh /usr/local/bin/
ADD https://linux.dropbox.com/packages/dropbox.py /usr/local/bin/dropbox.py
RUN chmod 0755 /usr/local/bin/dropbox.py /usr/local/bin/dockerinit.sh

ENTRYPOINT ["/usr/local/bin/dockerinit.sh"]
