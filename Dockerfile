FROM node:18-alpine

# Set working directory inside the image
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy your source code
COPY . .

# Expose the port your app runs on
EXPOSE 8080

# Start the application
CMD ["node", "app.js"]
