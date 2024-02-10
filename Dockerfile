# Stage 1: Node.js and React.js setup
FROM node:latest AS react-build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . ./
RUN npm run build

# Stage 2: Java setup
FROM openjdk:latest AS java-build
WORKDIR /app
COPY . /app
RUN javac Main.java

# Stage 3: PHP setup
FROM php:latest AS php-build
WORKDIR /app
COPY . /app
# Add necessary PHP configurations and dependencies

# Stage 4: Final image
FROM node:latest
WORKDIR /app
COPY --from=react-build /app/build ./client
COPY --from=java-build /app/Main.class ./
COPY --from=php-build /app ./
# Copy any other necessary files and configurations
# Expose any necessary ports
# Set any environment variables
# Define the command to run your application
CMD ["node", "your_main_node_js_file.js"]
