# Use the official Node.js image
FROM node:18

# Create and change to the app directory
WORKDIR /usr/src/app

# Copy package.json to the container
COPY package.json ./

# Install dependencies to generate package-lock.json
RUN npm install

# Copy package-lock.json to the container
COPY package-lock.json ./

# Copy the rest of the application code
COPY . .

# Install dependencies again to ensure all packages are up-to-date
RUN npm install

# Expose the port the app runs on
EXPOSE 8080

# Define the command to run the app
CMD ["npm", "start"]
