FROM golang:latest AS trojan-go-builder

WORKDIR /

RUN git clone https://github.com/p4gefau1t/trojan-go.git \
    && cd trojan-go \
    && GOOS=linux GOARCH=amd64 go build -tags "full"
    
FROM app:latest

WORKDIR /config

ENV DOMAIN="example.com" \
    PASSWORD="password" \
    PORT=443

VOLUME [ "/acme", "/config" ]

COPY --from=trojan-go-builder /trojan-go/trojan-go /usr/bin/
COPY ./entry.sh /entry.sh

ENTRYPOINT [ "/entry.sh" ]
