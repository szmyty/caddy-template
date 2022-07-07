# Stage 1: Build production web application.
FROM node:latest AS builder

# Set working directory to
WORKDIR /app

# Install web application dependencies.
ADD web-app/package.json .
ADD web-app/package-lock.json .

RUN npm install

# Add the application source to the working directory.
ADD web-app .

# Create a production build of the application.
RUN npm run build

FROM caddy:latest

ADD Caddyfile /etc/caddy/Caddyfile

ADD entrypoint.sh .

# Copies static resources from builder stage
COPY --from=builder /app/build .

EXPOSE 2015

# Make data directory writeable.
# https://caddyserver.com/docs/automatic-https#storage
RUN chmod a+rwx -R $DATA_DIR

RUN xcaddy build --with github.com/caddy-dns/googleclouddns

ENTRYPOINT sh entrypoint.sh
