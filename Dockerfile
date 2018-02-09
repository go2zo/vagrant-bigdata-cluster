FROM centos:7
MAINTAINER Jiho Kim <go2zo@apexsoft.co.kr>

ENV JDK_VERSION jdk8

ARG HOSTNAME

# Upgrading system & Installing JDK
RUN yum -y update && \
    yum -y install wget

RUN URL=$(wget -qO- https://lv.binarybabel.org/catalog-api/java/$JDK_VERSION.txt?p=downloads.rpm) && \
    wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" $URL --output-document=/tmp/jdk-linux.rpm && \
    yum -y localinstall /tmp/jdk-linux.rpm && \
    rm -f /tmp/jdk-linux.rpm

# enable ntpd
#RUN yum -y install ntpd && \
#    sudo systemctl start ntpd

# Setting timezone
#RUN sudo timedatectl set-timezone Asia/Seoul

# Setting DNS
#RUN hostnamectl set-hostname $HOSTNAME && \
#    bash -c 'echo -e "NETWORKING=yes\nHOSTNAME=$HOSTNAME" >> /etc/sysconfig/network'
	
# disable iptables
#RUN systemctl disable firewalld

# disable SELinux, PackageKit, umask
#RUN setenforce 0 && \
#  systemctl disable packagekit && \
#  bash -c 'echo -e "umask 0022" >> /etc/profile'

RUN yum clean all

ENV JAVA_HOME /usr/java/latest
