# Stage 1: Build production web application.
FROM node:latest AS builder

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

ENTRYPOINT sh entrypoint.sh
