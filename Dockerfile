FROM bitnami/nginx:latest AS nginx

WORKDIR /app

COPY ./public .

EXPOSE 80/tcp