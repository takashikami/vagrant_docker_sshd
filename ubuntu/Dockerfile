# sshd
#
# VERSION               0.0.2

FROM ubuntu:14.04
MAINTAINER Sven Dowideit <SvenDowideit@docker.com>

ENV http_proxy http://172.16.80.83:10080/
ENV https_proxy https://172.16.80.83:10080/
ENV ftp_proxy ftp://172.16.80.83:8021/

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:tulip' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "UseDNS no" >> /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN mkdir -p /root/.ssh
ADD ssh/id_rsa.pub /root/.ssh/authorized_keys

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN for f in $(env | grep _proxy); do echo export $f; done >>/etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
