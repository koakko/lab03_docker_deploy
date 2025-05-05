#!/bin/bash

# Clean and build the Maven project
echo "Building Maven project..."
mvn clean package

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "Maven build successful!"
else
    echo "Maven build failed!"
    exit 1
fi

# Build Docker image
echo "Building Docker image..."
docker build -t my-web-app:latest .

# Check if Docker build was successful
if [ $? -eq 0 ]; then
    echo "Docker image built successfully!"
else
    echo "Docker build failed!"
    exit 1
fi

# Run Docker container
echo "Running Docker container..."
docker run -d -p 8090:8090 --name my-web-app-container my-web-app:latest

# Check if container is running
if [ $? -eq 0 ]; then
    echo "Docker container is running on port 8090!"
    echo "Access the application at: http://localhost:8090/hello"
else
    echo "Failed to run Docker container!"
    exit 1
fi