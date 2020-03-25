# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200325
# ARGUMENTs
ARG NODE_VERSION=13.10.1
ARG ALPINE_VERSION=3.10

FROM node:${NODE_VERSION}-alpine${ALPINE_VERSION}

# LABELs
LABEL maintainer="imyme6yo"
LABEL email="imyme6yo@gmail.com"

# ARGUMENTs
ARG DIR=code
ARG PROJECT=myapp
ARG PORT=9212

# ENVs
ENV PROJECT=${PROJECT}
ENV PORT=${PORT}

# Install Alpine Packages
RUN apk update

# Install vue-cli
RUN npm install -g create-nuxt-app

RUN mkdir ${DIR}
WORKDIR ${DIR}

EXPOSE ${PORT}