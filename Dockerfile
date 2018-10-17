FROM ubuntu:16.04

MAINTAINER AManhasnoname <athinghasnoname@gmail.com>

RUN apt-get update -y && \
    apt-get install -y supervisor && \
    apt-get install -y openssh-server && \
    apt-get install -y nano && \
    apt-get install -y tzdata && \
    apt-get install -y cron && \
    apt-get install -y git && \
    apt-get autoclean && apt-get autoremove && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

RUN mkdir /var/run/sshd
RUN echo 'root:QWER654321' |chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/^#?Port 22/Port 10000/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh
RUN wget -N --no-check-certificate -P /etc/supervisor/ https://raw.githubusercontent.com/Chennhaoo/Docker/master/supervisord.conf 

CMD ["/usr/bin/supervisord","-n", "-c", "/etc/supervisor/supervisord.conf"]
