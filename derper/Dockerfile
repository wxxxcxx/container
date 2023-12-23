FROM golang:latest AS builder

WORKDIR /app



RUN go install tailscale.com/cmd/derper@main


FROM debian:latest
WORKDIR /app

# ========= CONFIG =========
# - derper args
ENV DERP_HOST=derp.tailscale.com
ENV DERP_CERTS=/app/certs/
ENV DERP_STUN true
ENV DERP_VERIFY_CLIENTS false
# ==========================

# apt
RUN apt-get update  && \
    apt-get install -y openssl curl && \
    apt autoremove -y

COPY --from=builder /go/bin/derper /app/derper


ENTRYPOINT [ "/app/derper" ]

CMD ["--hostname=${DERP_HOST}", "--certmode=manual", "--certdir=${DERP_CERTS}", "--stun=${DERP_STUN}", "--verify-clients=${DERP_VERIFY_CLIENTS}"]