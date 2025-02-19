# Stage 1: Build React App
FROM node:18-alpine AS build
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json* ./
RUN npm ci

# Copy source files and build
COPY . ./
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html

# Expose the web server port
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


.