docker build -t cnscud/zookeeper:zk3.7-0.1 .

# for multiple platform
# docker buildx build --platform linux/amd64,linux/arm64 -t cnscud/zookeeper:zk3.7-0.2 . --push
