FROM ubuntu:18.04
MAINTAINER Justin Guagliata "justin@guagliata.com"
RUN apt-get update
RUN apt-get install -y  --no-install-recommends  supervisor openssh-server nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*
COPY etc /etc
RUN mkdir -p /run/sshd
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
EXPOSE  22 80
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]
