From golang:alpine

ENV WORKING_DIR /helloworld

RUN addgroup tmuser && \
    adduser -S -G tmuser tmuser

RUN mkdir -p $WORKING_DIR && \
    chown -R tmuser:tmuser $WORKING_DIR

RUN apk add --no-cache bash curl jq

ENV GOPATH /go
ENV PATH "$PATH:/go/bin"
RUN mkdir -p /go/src/github.com/helloworld/helloworld && \
    apk add --no-cache go build-base git && \
    cd /go/src/github.com/helloworld/helloworld && \
    git clone https://github.com/Nagaraj007/helloworld.git && \
    cd - && \
    rm -rf /go/src/github.com/helloworld/helloworld && \
    apk del go build-base git

VOLUME $WORKING_DIR

EXPOSE 26656


ENTRYPOINT ["helloworld"]

