# 快速指南: 一个支持初始化数据的Zookeeper Docker镜像

## 这是什么
一个zookeeper docker的镜像, 基于官方镜像, 不过支持导入数据: 第一次启动时可以从文件里导入初始化数据.

## 维护人员
[飞云](https://github.com/cnscud/cnscud-docker)

# 支持的版本 (如需新版, 可以在此基础上编写, 因为很简单)

-	[`zk3.6-0.1`](https://github.com/cnscud/cnscud-docker/blob/main/docker-zookeeper/dockerimage/3.6/Dockerfile)
-	[`zk3.7-0.1`](https://github.com/cnscud/cnscud-docker/blob/main/docker-zookeeper/dockerimage/3.7/Dockerfile)

# 相关入口

- **有问题**:  
  [https://github.com/31z4/zookeeper-docker/issues](https://github.com/cnscud/cnscud-docker/issues)

- **源码仓库**:  
  [README](https://github.com/cnscud/cnscud-docker/tree/main/docker-zookeeper)


# 如何使用

## 命令行启动

```shell
docker run --name zk1 -d -p 2181:2181 cnscud/zookeeper:zk3.6-0.1
```

## 用docker-compose启动

下面是一个例子: `samples/docker-compose1/docker-compose.yml`:

```yaml
version: '3'
services:
  cnscud-zookeeper:
    image: cnscud/zookeeper:zk3.6-0.1
    volumes:
      - ./init.data:/init.data/
      - ./rundata/data:/data
      - ./rundata/logs:/datalog
    container_name: cnscud-sample-zk1
    environment:
      ZOOKEEPER_CLIENT_PORT: 2181
      ZOOKEEPER_TICK_TIME: 2000
    ports:
      - "2181:2181"
    restart: on-failure
    ## use the hostname in project
    hostname: cnscud-sample-zk1.cnscud.com
```

你可以在  samples/docker-compose1 目录下发现所需的所有文件.


## 配置


### Volume /init.data/ 和脚本文件 "import.data.zk.sh"

你可以通过绑定 volume "/init.data/" 来启动初始化数据的操作, 在这个目录里, 你需要放一个  "import.data.zk.sh" 文件, 这个文件需要是有执行权限的(例如755).

内容参考如下:

```shell
#!/bin/bash

## for init zookeeper data, you need update this file.
##
## author: felix zhang https://github.com/cnscud/  2021.8.22
##
## please make sure the file 755
##


CMD=`which zkCli.sh`
find="1"
if [ -z $CMD ]
then
	find="0"
fi

if [ $find = "0" ]
then
	CMD="$ZK_HOME/bin/zkCli.sh"
fi

echo $CMD

if [ -z $CMD ]
then
  echo "not found zkCli.sh, please check!!!"
  exit 1
fi


$CMD  create /xpower "1"
$CMD  create /xpower/cache "1"
$CMD  create /xpower/config "1"
$CMD  create /xpower/dbn "1"

## read from file!!!
## read from file!!!
## read from file!!!
$CMD  create /xpower/cache/redis.test "`cat /init.data/redis.test.conf`"
$CMD  create /xpower/config/kafka "`cat /init.data/kafka.conf`"
$CMD  create /xpower/dbn/cavedemo "`cat /init.data/mysql.cavedemo.conf`"

```

在这个脚本里, 你使用zookeeper自带的zkCli.sh 脚本创建你的节点, 可以通过下面的命令**从文件读入节点内容**:
> "`cat /init.data/kafka.conf`"


## 官方信息
更多配置选项, 更多信息, 请阅读: https://hub.docker.com/_/zookeeper

## 参考
    官方 Docker: https://hub.docker.com/_/zookeeper
    参考: https://stackoverflow.com/questions/41424007/how-can-i-dockerize-apache-zookeeper-with-seed-data-inserted/41424769
    参考: http://www.xknote.com/ask/60d2a60cddc44.html
