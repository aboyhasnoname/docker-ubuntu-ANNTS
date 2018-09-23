FROM ubuntu:16.04

MAINTAINER ChennHaoo <SSR SSPanel-V3-Mod>

RUN apt-get update -y && \
    apt-get install -y openssh-server nano cron git && \
    apt-get install -y tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

RUN mkdir /var/run/sshd
RUN echo 'root:sLfrk=A?eTyD!wk&fb' |chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/^#?Port 22/Port 10000/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

CMD ["/usr/sbin/sshd", "-D"]
	
	
	
	
