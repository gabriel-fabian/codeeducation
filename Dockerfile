FROM golang:alpine AS builder

WORKDIR /app

RUN apk add upx

COPY hello_world.go .

RUN go build -ldflags "-s -w" hello_world.go
RUN upx --brute hello_world

FROM ibmcom/busybox:1.30.1

COPY --from=builder /app/hello_world .

RUN chmod +x hello_world

CMD [ "./hello_world" ]