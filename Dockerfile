FROM roninkenji/slackware-base:latest
MAINTAINER roninkenji

RUN mkdir -p /dropbox/Dropbox /dropbox/.dropbox /dropbox/.dropbox-dista
WORKDIR /dropbox
EXPOSE 17500


RUN slackpkg -batch=on -default_answer=yes install python ca-certificates && ( cd /etc/ssl/certs; grep -v '^#' /etc/ca-certificates.conf | while read CERT; do ln -fsv /usr/share/ca-certificates/$CERT `basename ${CERT/.crt/.pem}`; ln -fsv /usr/share/ca-certificates/$CERT `openssl x509 -hash -noout -in /usr/share/ca-certificates/$CERT`.0; done )

RUN wget -O /usr/local/bin/dropbox.py https://www.dropbox.com/download?dl=packages/dropbox.py && chmod +x /usr/local/bin/dropbox.py

RUN wget -O- https://www.dropbox.com/download?plat=lnx.x86_64 | tar -C /usr/local -zx && chown -Rv root:root .

ADD myinit.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/myinit.sh
ENTRYPOINT ["/usr/local/bin/myinit.sh"]

