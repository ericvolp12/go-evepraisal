FROM golang:1.11-alpine
LABEL maintainer="sudorandom <https://github.com/ericvolp12/go-evepraisal>"
WORKDIR $GOPATH/src/github.com/ericvolp12/go-evepraisal
RUN apk --update add --no-cache --virtual build-dependencies git gcc musl-dev make bash && \
    git clone https://github.com/ericvolp12/go-evepraisal.git . && \
    export GO111MODULE=on ENV=prod && \
    make setup && \
    make build && \
    make install && \
    mkdir /evepraisal/ && \
    mv $GOPATH/bin/evepraisal /evepraisal/evepraisal && \
    rm -rf $GOPATH && \
    apk del build-dependencies && \
    mkdir /evepraisal/db
WORKDIR /evepraisal/
CMD ["./evepraisal"]
