FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND="noninteractive" apt-get -y install --no-install-recommends \
    nginx openssl curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./nginx.conf /etc/nginx/nginx.conf

VOLUME /etc/letsencrypt
VOLUME /var/www/html
VOLUME /etc/nginx/conf.d
VOLUME /etc/nginx/locations

EXPOSE 80/tcp
EXPOSE 443/tcp

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
