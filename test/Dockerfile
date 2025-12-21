FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN apt-get update && apt-get install -y curl git sudo locales && \
    locale-gen ja_JP.UTF-8

ENV LANG=ja_JP.UTF-8

RUN useradd -m -s /bin/bash myenvuser && \
    echo "myenvuser:password" | chpasswd && \
    echo "myenvuser ALL=(ALL) ALL" >> /etc/sudoers

WORKDIR /home/myenvuser

CMD ["sleep", "infinity"]
