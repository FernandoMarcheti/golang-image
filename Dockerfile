FROM golang:1.17 AS build

WORKDIR /go/src/app
COPY . .

RUN go mod init
RUN go get -d -v ./...
RUN go install -v ./...
RUN mkdir bin
RUN go build -o bin main/hello.go

FROM scratch
COPY --from=build /go/src/app/bin /usr/bin

ENTRYPOINT [ "hello" ]