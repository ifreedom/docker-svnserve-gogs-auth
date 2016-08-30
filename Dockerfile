FROM centos:7
MAINTAINER ifreedom.cn@gmail.com

# Update the image
# COPY CentOS-Base.repo /etc/yum.repos.d/ #如果打算使用国内镜像，则取消注释这句
RUN yum update -y

ENV S6_OVERLAY_VERSION v1.18.1.5
ADD https://github.com/just-containers/s6-overlay/releases/download/$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / --exclude="./bin" --exclude="./sbin" && \
    tar xzf /tmp/s6-overlay-amd64.tar.gz -C /usr ./bin ./sbin
# workaround for centos /run noexec flag
RUN mkdir -p /var/s6-run && \
    mv /var/run /var/origin-run && \
    ln -sf s6-run /var/run

RUN yum install -y subversion cyrus-sasl cyrus-sasl-plain

COPY rootfs /

ENV GOGS_HOST http://gogs

VOLUME ["/data"]
EXPOSE 3690
ENTRYPOINT ["/init"]
