FROM bitnami/nginx:latest AS nginx

WORKDIR /app

COPY ./public .
