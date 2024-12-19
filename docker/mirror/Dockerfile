FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND="noninteractive" apt-get -y install --no-install-recommends \
    nginx libnginx-mod-http-fancyindex rsync curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
