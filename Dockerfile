FROM centos:7

# As of July 1st, 2024, mirrorlist.centos.org is gone and we need to switch to vault.centos.org
RUN sed -i s,mirror.centos.org,vault.centos.org,g /etc/yum.repos.d/CentOS-*.repo; \
    sed -i s,^#.*baseurl=http,baseurl=http,g /etc/yum.repos.d/CentOS-*.repo; \
    sed -i s,^mirrorlist=http,#mirrorlist=http,g /etc/yum.repos.d/CentOS-*.repo

# ulimit -n 1024 is needed here to fix yum update's slowness. The default ulimit is >1M for some reason.
RUN ulimit -n 1024 && yum -y update && yum clean all -y

