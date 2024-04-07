# 编译命令 docker build -t java:maven3.9-jdk8-temurin-alpine -f maven3.9-jdk8-temurin.dockerfile . 
# 推送华为云命令
# docker tag java:maven3.9-jdk8-temurin-alpine swr.cn-east-3.myhuaweicloud.com/xryf/java:maven3.9-jdk8-temurin-alpine
# docker push swr.cn-east-3.myhuaweicloud.com/xryf/java:maven3.9-jdk8-temurin-alpine
# ubuntu22 jammy
FROM maven:3.9.4-eclipse-temurin-8-alpine

LABEL author='aLoNe.Adams.K'

# 时区
ENV TZ=Asia/Shanghai

# 容器内包地址
ENV CONTAINER_PACKAGE_URL=mirrors.huaweicloud.com

#RUN if [ $CONTAINER_PACKAGE_URL ] ; then sed -i "s/archive.ubuntu.com/${CONTAINER_PACKAGE_URL}/g" /etc/apt/sources.list ; fi
#RUN if [ $CONTAINER_PACKAGE_URL ] ; then sed -i "s/security.ubuntu.com/${CONTAINER_PACKAGE_URL}/g" /etc/apt/sources.list ; fi

RUN if [ $CONTAINER_PACKAGE_URL ] ; then sed -i "s/dl-cdn.alpinelinux.org/${CONTAINER_PACKAGE_URL}/g" /etc/apk/repositories ; fi
RUN apk update

RUN cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
    && echo "$TZ" > /etc/timezone

# maven仓库配置文件
COPY ./settings.xml /usr/share/maven/ref/
