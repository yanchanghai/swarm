FROM golang:1.5.2

COPY . /go/src/github.com/docker/swarm
WORKDIR /go/src/github.com/docker/swarm

ENV GOPATH /go/src/github.com/docker/swarm/Godeps/_workspace:$GOPATH
RUN CGO_ENABLED=0 go install -v -a -tags netgo -installsuffix netgo -ldflags "-w -X github.com/docker/swarm/version.GITCOMMIT `git rev-parse --short HEAD` -X github.com/docker/swarm/version.BUILDTIME \"`date -u`\""

ENV SWARM_HOST :2375
EXPOSE 2375

VOLUME $HOME/.swarm

ENTRYPOINT ["swarm"]
CMD ["--help"]
