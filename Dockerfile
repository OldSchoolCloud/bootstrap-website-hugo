FROM docker.io/library/golang:1.23-alpine AS base

RUN apk add --no-cache \
    curl \
    gcc \
    g++ \
    musl-dev \
    build-base \
    libc6-compat

ARG HUGO_VERSION

RUN mkdir $HOME/src && \
    cd $HOME/src && \
    curl -L https://github.com/gohugoio/hugo/archive/refs/tags/v${HUGO_VERSION}.tar.gz | tar -xz && \
    cd "hugo-${HUGO_VERSION}" && \
    go install --tags extended

FROM base AS base_builder

RUN apk add --no-cache \
    runuser \
    git \
    openssh-client \
    rsync \
    npm && \
    npm install -D autoprefixer postcss-cli

RUN mkdir -p /var/hugo && \
    addgroup -Sg 1000 hugo && \
    adduser -Sg hugo -u 1000 -h /var/hugo hugo && \
    chown -R hugo: /var/hugo && \
    runuser -u hugo -- git config --global --add safe.directory /src

COPY --from=0 /go/bin/hugo /usr/local/bin/hugo

USER hugo:hugo

FROM base_builder AS base_app

WORKDIR /src

COPY . .

FROM nginx:1.25-alpine AS nginx

# Set workdir to the NGINX default dir.
WORKDIR /usr/share/nginx/html

# Copy HTML from previous build into the Workdir.
COPY --from=base_app /src/public .

# Expose port 80
EXPOSE 80/tcp