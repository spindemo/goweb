FROM golang:1.11-alpine as builder
WORKDIR /go/src/github.com/spindemo/goweb
COPY main.go  .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o goweb .

FROM alpine:latest
COPY --from=builder /go/src/github.com/spindemo/goweb/goweb .
ENTRYPOINT ["./goweb"]
