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

# Stage 2 - Builder Stage
FROM nginx:stable-alpine As Production

#Copy necessary nginx file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the built files from the 'builder' stage into the NGINX web root
# Vite's default output directory is 'dist'
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80. NGINX listens on this port by default.
EXPOSE 80

