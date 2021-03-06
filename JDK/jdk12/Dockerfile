FROM adoptopenjdk/openjdk12:latest
LABEL MAINTAINER Ashwin Rayaprolu <ashwin.rayaprolu@gmail.com>

CMD ["gradle"]

ENV GRADLE_HOME /opt/gradle

RUN set -o errexit -o nounset \
    && echo "Adding gradle user and group" \
    && groupadd --system --gid 1000 gradle \
    && useradd --system --gid gradle --uid 1000 --shell /bin/bash --create-home gradle \
    && mkdir /home/gradle/.gradle \
	&& mkdir /home/gradle/.m2 \
	&& mkdir /home/gradle/.ssh \
    && chown --recursive gradle:gradle /home/gradle \
    \
    && echo "Symlinking root Gradle cache to gradle Gradle cache" \
    && ln -s /home/gradle/.gradle /root/.gradle

VOLUME /home/gradle/.gradle
VOLUME /home/gradle/.m2
VOLUME /home/gradle/.ssh

WORKDIR /home/gradle

#COPY sources.list /etc/apt/sources.list	

RUN apt-get clean && apt-get --allow-unauthenticated  update && apt-get --allow-unauthenticated  install -y gnupg2 gnupg gnupg1
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
RUN apt-get --allow-unauthenticated update \
    && apt-get install --yes --no-install-recommends \
        fontconfig \
        unzip \
        wget \
        \
        bzr \
        git \
        git-lfs \
        mercurial \
        openssh-client \
        subversion \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get install -y maven

ENV GRADLE_VERSION 6.2.1
ARG GRADLE_DOWNLOAD_SHA256=a68ca7ba57f3404c3f6fc1f70a02d3a7d78652e6b46bbfaff83fc9a17168c279
RUN set -o errexit -o nounset \
    && echo "Downloading Gradle" \
    && wget --no-verbose --output-document=gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" \
    \
    && echo "Checking download hash" \
    && echo "${GRADLE_DOWNLOAD_SHA256} *gradle.zip" | sha256sum --check - \
    \
    && echo "Installing Gradle" \
    && unzip gradle.zip \
    && rm gradle.zip \
    && mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" \
    && ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle \
    \
    && echo "Testing Gradle installation" \
    && gradle --version


# update and install all required packages (no sudo required as root)
# https://gist.github.com/isaacs/579814#file-only-git-all-the-way-sh
RUN apt-get update -yq && apt-get upgrade -yq && \
	apt-get install -yq curl git nano


# install curl 
RUN apt-get install -y curl
# get install script and pass it to execute: 
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash

RUN apt-get install -y nodejs build-essential

# fix npm - not the latest version installed by apt-get
RUN npm install -g npm


RUN npm -g update
RUN npm -g rebuild node-sass
#RUN RUN su - gradle -c "npm  uninstall node-sass"
#RUN RUN su - gradle -c "npm  i node-sass --force"

