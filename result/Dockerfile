# Use the Node.js 24 slim image

FROM node:24.18-slim AS base

# Install curl for health checks and tini for process management

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl tini && \
    rm -rf /var/lib/apt/lists/*

# Set the application directory

WORKDIR /usr/local/app

# Copy dependency manifests

COPY package*.json ./

# Install dependencies and move them to a shared location

RUN npm ci && \
    npm cache clean --force && \
    mv /usr/local/app/node_modules /node_modules

# Development stage

FROM base AS dev

# Install nodemon for development
RUN npm install -g nodemon

# Copy application files

COPY . .

# Development port

ENV PORT=80
EXPOSE 80

# Start the application with nodemon

ENTRYPOINT ["nodemon", "--inspect=0.0.0.0", "server.js"]

# Production stage

FROM base AS production

# Use the existing non-root node user

USER node

# Copy application files with appropriate ownership

COPY --chown=node:node . .

# Configure an unprivileged application port

ENV PORT=8080
EXPOSE 8080

# Start the production application

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["node", "server.js"]
