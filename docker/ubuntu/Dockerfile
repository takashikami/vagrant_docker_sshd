# sshd
#
# VERSION               0.0.2

FROM ubuntu:14.04
MAINTAINER Sven Dowideit <SvenDowideit@docker.com>

ENV http_proxy http://10.208.0.10:8080/
ENV https_proxy https://10.208.0.10:8080/

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
#RUN echo 'root:xxxxxxxx' | chpasswd
RUN echo 'root:'$(dd if=/dev/urandom bs=1 count=9 2>/dev/null | base64) | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "UseDNS no" >> /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN mkdir -p /root/.ssh
ADD ssh/id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN for f in $(env | grep _proxy); do echo export $f; done >>/etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
