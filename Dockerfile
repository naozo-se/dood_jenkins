FROM jenkins/jenkins:2.504.2-lts

USER root

# パッケージ更新
RUN apt-get update

# # yml経由で .env の定義値を受け取り
ARG DOCKER_GID=${DOCKER_GID}
ARG JENKINS_UID=${JENKINS_UID}
ARG JENKINS_GID=${JENKINS_GID}
ARG JENKINS_USERNAME=${JENKINS_USERNAME}
ARG JENKINS_GROUPNAME=${JENKINS_GROUPNAME}
ARG HOST_DOCKER_VERSION=${HOST_DOCKER_VERSION}
ARG HOST_DOCKER_COMPOSE_VERSION=${HOST_DOCKER_COMPOSE_VERSION}

# # ユーザー情報変更
RUN groupmod -g $JENKINS_GID jenkins
RUN groupmod -n $JENKINS_GROUPNAME jenkins
RUN usermod -u $JENKINS_UID jenkins
RUN usermod -l $JENKINS_USERNAME jenkins

# Dockerグループ追加
RUN groupadd -g $DOCKER_GID docker && usermod -aG docker $JENKINS_USERNAME

# Docker、docker-compose 追加
ENV DOCKER_VERSION $HOST_DOCKER_VERSION
RUN curl -fL -o docker.tgz "https://download.docker.com/linux/static/test/x86_64/docker-$DOCKER_VERSION.tgz" && \
    tar --strip-component=1 -xvaf docker.tgz -C /usr/bin

ENV DOCKER_COMPOSE_VERSION $HOST_DOCKER_COMPOSE_VERSION
RUN curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose


# ユーザー切り替え
USER $JENKINS_USERNAME
