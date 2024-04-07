# 编译命令 docker build -t java:jre8-temurin-v1 -f jre8-temurin.dockerfile . 
# 推送华为云命令
# docker tag java:jre8-temurin-v1 aloneit/lnmp:jre8-temurin-v1
# docker push aloneit/lnmp:jre8-temurin-v1
# ubuntu22 jammy
FROM eclipse-temurin:8-jre

LABEL author='aLoNe.Adams.K'

# 环境变量
ENV USER_PASSWORD=123456!@#

# 时区
ENV TZ=Asia/Shanghai

# 容器内包地址
ENV CONTAINER_PACKAGE_URL=mirrors.huaweicloud.com

RUN if [ $CONTAINER_PACKAGE_URL ] ; then sed -i "s/archive.ubuntu.com/${CONTAINER_PACKAGE_URL}/g" /etc/apt/sources.list ; fi
RUN if [ $CONTAINER_PACKAGE_URL ] ; then sed -i "s/security.ubuntu.com/${CONTAINER_PACKAGE_URL}/g" /etc/apt/sources.list ; fi
RUN apt update \
    && apt upgrade -y \
    # 安装所需软件
    # procps 
    && apt install -y inetutils-ping telnet

RUN cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
    && echo "$TZ" > /etc/timezone

# 创建相应目录
RUN mkdir /data/wwwroot -p \
    && mkdir /data/wwwlogs \
    # 创建用户
    && useradd -u 10000 -s /bin/bash www \
    && echo "www:${USER_PASSWORD}}" | chpasswd \
    && chown www:www /data/wwwroot -Rf \
    && chmod 755 /data/wwwroot \
    && chown www:www /data/wwwlogs \
    && chmod 755 /data/wwwroot

COPY ./java.security /opt/java/openjdk/lib/security/java.security

# 变更工作目录
WORKDIR /data/wwwroot