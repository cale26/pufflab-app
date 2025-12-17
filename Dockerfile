# Use Alpine Linux as the base image
FROM alpine:latest

# Set /apps as the working directory
WORKDIR /apps

#Copy the repository into the working directory
COPY . .

#Print a message to confirm Docker image is successfully built
CMD ["echo", "Pufflab Application Docker Image is successfully built."]