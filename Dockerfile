FROM centos:7

RUN curl -s https://packagecloud.io/install/repositories/varnishcache/varnish60lts/script.rpm.sh | bash

RUN yum install epel-release -y

RUN yum groupinstall "Development Tools" "Development Libraries" -y

RUN yum install -y jemalloc varnish varnish-devel automake libtool autoconf-archive python-docutils
