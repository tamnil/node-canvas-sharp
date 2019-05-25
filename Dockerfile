# get node from oficial image - debian 9
FROM node:8
MAINTAINER Tamnil Saito Junior (tamnil@gmail.com)

RUN apt update && apt upgrade -y
RUN apt install sudo zsh vim tmux git -y

# Required for node-canvas
RUN apt install build-essential libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev -y

# Required for sharp
RUN apt install libvips-dev -y

RUN su root

# USER root
# WORKDIR /root/

RUN sudo npm install -g --unsafe-perm sharp canvas

RUN sudo npm install -g mocha grunt-cli

## temporary mongo install

RUN apt install mongodb -y


RUN service mongodb start


RUN useradd -ms /bin/bash newuser
RUN usermod -a -G sudo www-data
RUN mkdir /var/www/app -p


user newuser
WORKDIR /var/www/app



COPY . /var/www/teste



