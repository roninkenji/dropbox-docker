FROM roninkenji/slackware-base:latest
MAINTAINER roninkenji

RUN mkdir -p /dropbox/Dropbox /dropbox/.dropbox /dropbox/.dropbox-dist
WORKDIR /dropbox
EXPOSE 17500
EXPOSE 17500/udp

RUN slackpkg -batch=on -default_answer=yes install glibc-[0-9]* shadow python
RUN wget -O /usr/local/bin/dropbox.py https://www.dropbox.com/download?dl=packages/dropbox.py && chmod +x /usr/local/bin/dropbox.py
RUN wget -O- https://www.dropbox.com/download?plat=lnx.x86_64 | tar -C /usr/local -zx && chown -Rv root:root .

ADD myinit.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/myinit.sh
ENTRYPOINT ["/usr/local/bin/myinit.sh"]

