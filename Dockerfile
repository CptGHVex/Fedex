# Use the official Node.js image
FROM node:18

# Create and change to the app directory
WORKDIR /usr/src/app

# Copy package.json
COPY package.json ./

# Ensure package-lock.json is generated and install dependencies
RUN npm install --package-lock

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 8080

# Define the command to run the app
CMD ["npm", "start"]
