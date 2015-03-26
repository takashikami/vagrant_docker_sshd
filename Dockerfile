# sshd
#
# VERSION               0.0.2

FROM centos:6
MAINTAINER Sven Dowideit <SvenDowideit@docker.com>

ENV http_proxy http://172.16.80.83:10080/
ENV https_proxy https://172.16.80.83:10080/
ENV ftp_proxy ftp://172.16.80.83:8021/

RUN sed -i 's/^enabled=1$/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf
RUN sed -i \
    -e '/^mirrorlist=/d' \
    -e 's~#baseurl=http://mirror.centos.org/~baseurl=http://ftp.riken.jp/Linux/~' \
    /etc/yum.repos.d/*.repo

RUN yum install -y openssh-server openssh-clients tar
RUN /etc/init.d/sshd start
RUN /etc/init.d/sshd stop
RUN mkdir -p /var/run/sshd
#RUN echo 'root:xxxxxxxx' | chpasswd
RUN echo 'root:'$(dd if=/dev/urandom bs=1 count=9 2>/dev/null | base64) | chpasswd

RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config
RUN echo "UseDNS no" >> /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN mkdir -p /root/.ssh
ADD ssh/id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys

#ENV NOTVISIBLE "in users profile"
#RUN echo "export VISIBLE=now" >> /etc/profile
RUN for f in $(env | grep _proxy); do echo export $f; done >>/etc/profile.d/proxy.sh

ADD jdk/jdk-7u75-linux-x64.tar.gz /opt/java
ADD jdk/jdk-8u40-linux-x64.tar.gz /opt/java
RUN echo 'export JAVA_HOME=/opt/java/jdk1.8.0_40' >>/etc/profile.d/java.sh
RUN echo 'export PATH=$JAVA_HOME/bin:$PATH' >>/etc/profile.d/java.sh

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
