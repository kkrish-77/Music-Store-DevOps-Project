# Use Node.js 20 Alpine as base image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the source code
COPY . .

# Expose app port (check if your app uses 3000 or 5173 etc.)
EXPOSE 8080

# Run the app
CMD ["npm", "run", "dev"]
