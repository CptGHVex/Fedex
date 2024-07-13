# Use the official Node.js image from the Docker Hub
FROM node:18

# Create and change to the app directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json files to the app directory
COPY package*.json ./

# Install app dependencies using npm ci for a clean and deterministic install
RUN npm ci --only=production

# Copy the rest of the app's source code to the app directory
COPY . .

# Expose the port the app runs on
EXPOSE 8080

# Define the command to run the app
CMD [ "node", "fx-proxy.js" ]