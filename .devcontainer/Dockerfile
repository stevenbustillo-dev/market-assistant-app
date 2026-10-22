FROM mcr.microsoft.com/devcontainers/base:trixie AS dev

ARG USER=flutter
ARG JAVA_HOME=java/jdk
ARG ANDROID_HOME=Android/sdk
ARG ANDROID_SDK_TOOLS=$ANDROID_HOME/cmdline-tools
ARG BUILD_TOOLS_VERSION=36.0.0
ARG PLATFORM_VERSION=36

# Dependencies as root
RUN apt update && apt upgrade -y
RUN apt install -y curl git wget unzip xz-utils zip libglu1-mesa

# flutter user
RUN usermod -l $USER vscode && groupmod -n $USER vscode && usermod -d /home/$USER -m $USER && echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USER
WORKDIR /home/$USER

RUN git config --global core.autocrlf input
RUN git config --global --add safe.directory /workspaces/market-assistant-app

# JDK
RUN mkdir -p java

RUN wget -O jdk-25.tar.gz https://download.java.net/openjdk/jdk25/ri/openjdk-25+36_linux-x64_bin.tar.gz
RUN tar -xzf jdk-25.tar.gz && rm jdk-25.tar.gz
RUN mv jdk-25 $JAVA_HOME

ENV JAVA_HOME=/home/$USER/$JAVA_HOME
ENV PATH=$PATH:$JAVA_HOME/bin

# Android SDK
RUN mkdir -p $ANDROID_SDK_TOOLS

RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-15859902_latest.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv cmdline-tools $ANDROID_SDK_TOOLS/latest/

RUN yes | $ANDROID_SDK_TOOLS/latest/bin/sdkmanager --licenses
RUN $ANDROID_SDK_TOOLS/latest/bin/sdkmanager "build-tools;${BUILD_TOOLS_VERSION}" "platform-tools" "platforms;android-${PLATFORM_VERSION}" "sources;android-${PLATFORM_VERSION}"

ENV ANDROID_HOME=/home/$USER/$ANDROID_HOME
ENV PATH=$PATH:$ANDROID_HOME/platform-tools

# Flutter SDK
RUN git clone --depth 1 --branch stable https://github.com/flutter/flutter.git

RUN git config --global --add safe.directory /home/$USER/flutter

ENV PATH=$PATH:/home/$USER/flutter/bin

# Flutter Licenses
RUN flutter --disable-analytics
RUN flutter doctor
RUN yes | flutter doctor --android-licenses
