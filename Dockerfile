# Start with a Node.js base image
FROM node:14 AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install the app dependencies
RUN npm install --production

# Copy the rest of the application files
COPY . .

# Build the app (if applicable)
# RUN npm run build

# Start with a smaller image for the production stage
FROM node:14 AS production

# Create and change to the app directory
WORKDIR /app

# Copy the built application from the builder stage
COPY --from=builder /app .

# Expose the application port
EXPOSE 3000

# Command to run the application
CMD [ "node", "server.js" ]