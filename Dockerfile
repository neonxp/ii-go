FROM golang:1.21.0 as builder
WORKDIR /usr/app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o /usr/app/bin/ii-tool ./ii-tool
RUN CGO_ENABLED=0 go build -o /usr/app/bin/ii-node ./ii-node

FROM alpine
RUN apk update \
        && apk upgrade \
        && apk add --no-cache \
        ca-certificates make \
        && update-ca-certificates 2>/dev/null || true
WORKDIR /usr/app
COPY --from=builder /usr/app/bin/ii-tool /usr/app/ii-tool
COPY --from=builder /usr/app/bin/ii-node /usr/app/ii-node
COPY Makefile .
RUN chmod +x /usr/app/ii-tool

ENTRYPOINT ["make", "start"]