FROM zookeeper:3.6

##
## docker image for zookeeper with init data feature.
##
## author: Felix Zhang<cnscud@gmail.com>  2021.8.23
## website: https://github.com/cnscud/cnscud-docker

LABEL OG=cnscud.com
LABEL maintainer="Felix Zhang<cnscud@gmail.com>"
LABEL reference="https://github.com/cnscud/cnscud-docker"

## my entrypoint script
ADD cnscud-docker-entrypoint.sh /

## timezone
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

## declare the volumen for init data
VOLUME /init.data

## declare the port
EXPOSE 2181

## ===================================

## from official zookeeper as reference
# ENTRYPOINT ["/docker-entrypoint.sh"]
# CMD ["zkServer.sh" "start-foreground"]

ENTRYPOINT ["/cnscud-docker-entrypoint.sh"]
CMD ["zkServer.sh","start-foreground"]
