FROM alpine:edge

RUN apk add --no-cache abuild build-base sudo
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# enable caching
RUN mkdir /etc/apk/cache
RUN apk update

# add abuild user
ARG UID
RUN adduser -u $UID -D -G abuild abuild

# allow sudo wothout password
RUN echo '%abuild ALL= NOPASSWD: ALL' > /etc/sudoers.d/nopassword_abuild

WORKDIR /home/abuild
USER abuild

# generate signing keys
RUN abuild-keygen -n -i -a
RUN sudo cp .abuild/*.pub /etc/apk/keys/
