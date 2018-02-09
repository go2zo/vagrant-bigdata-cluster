FROM centos:7
MAINTAINER Jiho Kim <go2zo@apexsoft.co.kr>

ENV JDK_VERSION jdk8
ENV JDK_RPM jdk-8u161-linux-x64.rpm

ARG HOSTNAME

# Installing JDK
ADD $JDK_RPM /tmp/
RUN yum -y localinstall /tmp/$JDK_RPM && \
    rm -f /tmp/$JDK_RPM

# Upgrading system
RUN yum -y update

# enable ntpd
RUN yum -y install ntpd && \
    systemctl start ntpd

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
