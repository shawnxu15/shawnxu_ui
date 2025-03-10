# Stage 1: Build the React app
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app's files
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Serve the built app
FROM node:18-alpine AS runner

# Set working directory
WORKDIR /app

# Install a lightweight web server
RUN npm install -g serve

# Copy the built app from the builder stage
COPY --from=builder /app/dist /app/dist

# Expose port 3000
EXPOSE 3000

# Serve the app
CMD ["serve", "-s", "dist", "-l", "3000"]
