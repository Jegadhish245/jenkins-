# Stage 1: Build dependencies
FROM node:18-alpine AS build

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json and install dependencies
# This leverages Docker's build cache: if the package files don't change,
# this layer won't be rebuilt.
COPY package*.json ./
RUN npm install

# Copy application source code
COPY . .

# Stage 2: Create the final, production-ready image
FROM node:18-alpine

# Set the working directory
WORKDIR /usr/src/app

# Set NODE_ENV to production for smaller images and better performance
ENV NODE_ENV=production

# Copy only the necessary files and dependencies from the 'build' stage
# The '--chown' flag ensures the 'node' user owns the files.
COPY --from=build --chown=node:node /usr/src/app ./

# Switch to a non-root user for security
USER node

# Expose the application port
EXPOSE 3000

# Start the application using the 'exec' form for proper signal handling.
# This ensures that shutdown signals are correctly handled by your app.
CMD ["node", "app.js"]

