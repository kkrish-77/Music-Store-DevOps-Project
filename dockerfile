# Stage 1 - Builder Stage
# Use Node.js 20 Alpine as builder image
FROM node:20-alpine As builder

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the source code
COPY . .

#Run the build command
RUN npm run build 

#