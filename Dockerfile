FROM alpine:edge
MAINTAINER Scott Mebberson <scott@scottmebberson.com>

# Add commonly used packages
RUN apk add --update bind-tools && \
    rm -rf /var/cache/apk/*

# Add s6-overlay
ENV S6_OVERLAY_VERSION v1.14.0.0

ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz
RUN tar xvfz /tmp/s6-overlay.tar.gz -C /

ADD root /

# Add the files
RUN rm /etc/s6/services/s6-fdholderd/down

ADD etcd /bin/
ADD etcdctl /bin/
ADD skydns /bin/
ADD registrator /bin/

#RUN apk --update add git mercurial go build-base && rm -rf /var/cache/apk/* && mkdir /go && export GOPATH="/go" && go get github.com/skynetservices/skydns && cd $GOPATH/src/github.com/skynetservices/skydns && go build -v && mv /go/bin/skydns /bin && go get github.com/gliderlabs/registrator && cd $GOPATH/src/github.com/gliderlabs/registrator && go build -v -ldflags "-X main.Version $(cat VERSION)" -o /bin/registrator && rm -rvf /go && apk del --purge git mercurial go build-base

#RUN apk --update add git mercurial go build-base && rm -rf /var/cache/apk/* && mkdir /go && export GOPATH="/go" && go get github.com/skynetservices/skydns && cd $GOPATH/src/github.com/skynetservices/skydns && go build -v && mv /go/bin/skydns /bin && go get github.com/etopian/registrator && cd $GOPATH/src/github.com/etopian/registrator && go build -v -ldflags "-X main.Version $(cat VERSION)" -o /bin/registrator && rm -rvf /go && apk del --purge git mercurial go build-base



# Expose the ports for nginx
#EXPOSE 53 53/udp 2379 2380 4001 7001
EXPOSE 53 53/udp 4001 2379



ENTRYPOINT ["/init"]
CMD []


