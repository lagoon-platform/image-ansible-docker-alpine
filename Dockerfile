FROM alpine:3.10
RUN apk update \ 
    && apk --no-cache --update add \
		git \
		openssl \
		openssh-client \
		ansible \
		python2 \
		py2-pip \
    && apk --update --virtual build-dependencies add \
		build-base \
		autoconf \
		automake \
    && pip install --upgrade pip \
    && mkdir -p /tmp/download \
    && git clone https://github.com/bryanpkc/corkscrew.git /tmp/download/corkscrew \
    && cd /tmp/download/corkscrew && autoreconf --install && ./configure && make install \
    && apk del build-dependencies \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*
