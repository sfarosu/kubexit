FROM golang:1.18.3-alpine3.16 as builder
RUN mkdir /build
WORKDIR /build
COPY . /build/
RUN CGO_ENABLED=0 GOOS=linux go build -o kubexit ./cmd/kubexit

FROM alpine:3.16
RUN apk --no-cache add ca-certificates tzdata
COPY --from=builder /build/kubexit /bin/
ENTRYPOINT ["kubexit"]
