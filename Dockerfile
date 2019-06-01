# get node from oficial image - debian 9
# FROM node:8
FROM ubuntu:bionic
MAINTAINER Tamnil Saito Junior (tamnil@gmail.com)

RUN apt-get update && apt-get install -y \
        curl \
        git \
        && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
        && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list


# RUN apt update  && apt upgrade -y && apt install -y  \
        # Required for node-canvas
    # build-essential libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev \
    # Required for sharp

RUN apt-get update && apt-get install -y \
    nodejs \
    yarn \
    libcairo2-dev \
    sudo \
    libjpeg-dev \
    libpango1.0-dev \
    libgif-dev \
    libpng-dev \
    libvips-dev \
    build-essential \
    g++ \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN su root

RUN sudo npm install -g --unsafe-perm sharp 
RUN sudo npm install -g --build-from-source --unsafe-perm canvas

RUN sudo npm install -g mocha grunt-cli pm2 jest nodemon

# RUN useradd -ms /bin/bash newuser
# RUN usermod -a -G sudo newuser
# RUN usermod -a -G www-data newuser
RUN mkdir /var/www/app -p

# USER newuser
WORKDIR /var/www/app

COPY ./src /var/www/app

RUN cd /var/www/app

USER 1000:1000

CMD nodemon /var/www/app
