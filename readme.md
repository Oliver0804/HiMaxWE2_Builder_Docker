# Grove Vision AI Module V2 Firmware Compilation

This repository contains the Docker configuration for building firmware for the Grove Vision AI Module V2 on a Linux environment, specifically tested on Ubuntu 20.04.

## Prerequisites

- Docker installed on your system.
- Basic understanding of Docker and containerization.

## Building the Docker Image

Clone this repository to your local machine and navigate into the cloned directory. Build the Docker image using the following command:

```bash
docker build -t grove-vision-ai-module-v2:1.0 .
```

This command builds a Docker image named grove-vision-ai-module-v2 with the tag 1.0 based on the Dockerfile in the current directory.

## Running the Container

To run the container and compile the firmware, use the following command:

```bash
docker run -it --name my-grove-vision-ai grove-vision-ai-module-v2:1.0
```

If you wish to mount a directory from your host machine to the container to store the firmware files, use the following command:

```bash
docker run -it --name my-grove-vision-ai -v /path/to/local/firmware:/root/firmware grove-vision-ai-module-v2:1.0
```

Make sure to replace /path/to/local/firmware with the path to the directory on your host machine where you want the firmware files to be stored.

## Accessing the Container

If you need to access the container after it is running, you can start a bash shell inside the container using:

```bash
docker exec -it my-grove-vision-ai /bin/bash
```

This will allow you to interact with the container's file system and run commands inside the container.

## Cleaning Up

To stop and remove the container when you are done, use the following command:

```bash
docker-compose down
```

This command stops the running container and removes it.

## Notes

- The build script and Dockerfile are configured based on the assumption that they will be run on a Linux environment, specifically tested on Ubuntu 20.04.
- Make sure that the build-firmware.sh script is in the same directory as your Dockerfile and that it has executable permissions.
