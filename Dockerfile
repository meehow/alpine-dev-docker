FROM alpine

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
# enable http proxy caching
RUN sed -i s/^https:/http:/g /etc/apk/repositories
RUN apk add abuild build-base sudo git

# add abuild user
ARG UID
RUN adduser -u $UID -D -G abuild abuild

# allow sudo wothout password
RUN echo '%abuild ALL= NOPASSWD: ALL' > /etc/sudoers.d/nopassword_abuild

USER abuild

# generate signing keys
RUN abuild-keygen -n -i -a
RUN sudo cp /home/abuild/.abuild/*.pub /etc/apk/keys/

WORKDIR /aports
