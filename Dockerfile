# Use multi-architecture Node.js image with build tools
FROM --platform=linux/amd64 node:20-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Install pnpm
RUN npm install -g pnpm

# Copy package files
COPY package.json pnpm-lock.yaml* ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy .env file
COPY .env .

# Copy the rest of the application code
COPY . .

# Build the application
RUN pnpm run build

# Command to run the application
CMD ["pnpm", "run", "start"]
