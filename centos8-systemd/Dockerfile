FROM centos:centos8.2.2004

ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*; \
    rm -f /etc/systemd/system/*.wants/*; \
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*; \
    rm -f /lib/systemd/system/anaconda.target.wants/*;

#RUN sed -i -e "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-* \
#    ; sed -i -e "s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g" /etc/yum.repos.d/CentOS-*

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
    ; sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum update -y

#RUN yum install -y systemd epel-release sudo nano wget git cmake tbb-devel systemtap-sdt-devel ant ncurses-devel numactl-devel

#RUN yum group install -y "Development Tools"

#RUN yum install -y epel-release dnf-plugins-core
#RUN yum config-manager --set-enabled powertools
#RUN yum install -y  ninja-build ccache gcc-toolset-9 git wget which libevent-devel \
#  openssl-devel re2-devel libzstd-devel lz4-devel double-conversion-devel \
#  libdwarf-devel curl-devel cmake libicu-devel

#RUN yum remove -y gflags

# Required for Thrift
#RUN yum install -y autoconf automake libtool bison flex python3

# Required for google-cloud-storage
#RUN yum install -y curl-devel c-ares-devel libaio-devel protobuf-devel

#RUN yum install -y conda

#RUN mkdir -p /usr/local/src/Catch2-3.4.0 \
#        && curl -L https://github.com/catchorg/Catch2/archive/refs/tags/v3.4.0.tar.gz -o /usr/local/src/Catch2_v3.4.0.tar.gz \
#        && tar -zxvf /usr/local/src/Catch2_v3.4.0.tar.gz -C /usr/local/src/Catch2-3.4.0 --strip-components=1 \
#        && cd /usr/local/src/Catch2-3.4.0 \
#        && mkdir build && cd build && cmake .. \
#        && make && make install 


VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/sbin/init"]

