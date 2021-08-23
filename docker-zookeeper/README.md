# Quick reference | [中文版](README-zh.md)

## What is this 
A zookeeper Docker imge, based on official docker, but support import data. (initialize data from file at first time)

## Maintained by  
[Felix Zhang](https://github.com/cnscud/cnscud-docker)

# Supported tags and respective `Dockerfile` links

-	[`zk3.6-0.1`](https://github.com/cnscud/cnscud-docker/blob/main/docker-zookeeper/dockerimage/3.6/Dockerfile)
-	[`zk3.7-0.1`](https://github.com/cnscud/cnscud-docker/blob/main/docker-zookeeper/dockerimage/3.7/Dockerfile)

# Quick reference

- **Where to file issues**:  
     [https://github.com/31z4/zookeeper-docker/issues](https://github.com/cnscud/cnscud-docker/issues)

- **Source of this description**:  
     [README](https://github.com/cnscud/cnscud-docker/tree/main/docker-zookeeper)


# How to use this image

## Start a Zookeeper server instance

```shell
docker run --name zk1 -d -p 2181:2181 cnscud/zookeeper:zk3.6-0.1
```

## Start with docker-compose

Example `samples/docker-compose1/docker-compose.yml` for demo:

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

You can find all files in samples/docker-compose1 directory.


## Configuration


### Volume /init.data/ and file "import.data.zk.sh"

You can fire the data intilize action by configure the volume "/init.data/".

in this directory, you should put a file named "import.data.zk.sh" (maybe should be 755 permission), just like this sample:

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

You can import data from file for zookeeper node by  
> "`cat /init.data/kafka.conf`" 


## Official Docker Information
for more information, please read from official docker website: https://hub.docker.com/_/zookeeper

## reference
    Official Docker: https://hub.docker.com/_/zookeeper
    https://stackoverflow.com/questions/41424007/how-can-i-dockerize-apache-zookeeper-with-seed-data-inserted/41424769
    http://www.xknote.com/ask/60d2a60cddc44.html
