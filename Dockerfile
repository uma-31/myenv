FROM ubuntu:focal

ARG GROUP=developer

ARG USER=developer
ARG PASSWORD=password

ARG GID
ARG UID

RUN groupadd --gid ${GID} ${GROUP} && \
    useradd --gid ${GID} --uid ${UID} ${USER}

RUN apt-get update -y
RUN apt-get install -y \
    sudo \
    language-pack-ja-base language-pack-ja locales \
    git python3

RUN locale-gen ja_JP.UTF-8
RUN echo ${USER}:${PASSWORD} | chpasswd
RUN echo "${USER} ALL=(ALL) ALL" >> /etc/sudoers

ENV LANG=ja_JP.UTF-8

USER ${UID}
WORKDIR /home/${USER}/
