# Dockerfile
# Stage 1: Build dependencies
FROM node:18-alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .

# Stage 2: Create the final production image
FROM node:18-alpine
WORKDIR /usr/src/app
ENV NODE_ENV=production
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY . .
# Use a non-root user for security
USER node
EXPOSE 3000
CMD ["node", "server.js"]
