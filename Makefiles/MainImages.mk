# ===============================================================
# Main image (using base image)
# ===============================================================
MAIN_DOCKERFILE = docker/Dockerfile
# MAIN_IMAGE_NAME = iamteacher/blog_15min
MAIN_IMAGE_NAME = dimazyablicev/disk

# Build main image for AMD64
build-main-amd64:
	docker build \
		-t $(MAIN_IMAGE_NAME):amd64 \
		-f $(MAIN_DOCKERFILE) \
		--platform linux/amd64 \
		.

# Push main images to Docker Hub
push-main-images:
	docker push $(MAIN_IMAGE_NAME):amd64

# Complete workflow for building and publishing main images
update-main-images:
	make push-main-images
	@echo "Main images built successfully!"

# Run shell in AMD64 main image
shell-main-amd64:
	docker run --rm -it \
		--platform linux/amd64 \
		-v "$(PWD):/app" \
		$(MAIN_IMAGE_NAME):amd64 \
		/bin/bash

# Run Rails app in container on AMD64
run-rails-app-amd64:
	docker run --rm -it \
		--platform linux/amd64 \
		-v $(PWD):/app \
		-p 3000:3000 \
		$(MAIN_IMAGE_NAME):amd64 \
		bash -c "cd /app && bundle install && rails server -b 0.0.0.0"

# Clean main docker images related to this project
clean-main-images:
	@echo "Cleaning main images..."
	@echo "Removing tagged images..."
	-docker rmi $(MAIN_IMAGE_NAME):amd64 $(MAIN_IMAGE_NAME):latest
	@echo "Main images cleanup completed!"

# Help for main image building commands
help-main-image:
	@echo "=============================================================="
	@echo "Main image building commands:"
	@echo "=============================================================="
	@echo "  make build-main-amd64     - Build main image for AMD64"
	@echo "  make push-main-images     - Push main images to Docker Hub"
	@echo "  make update-main-images   - Build, push images"
	@echo "  make shell-main-amd64     - Enter shell of main AMD64 image"
	@echo "  make run-rails-app-amd64  - Run Rails app in AMD64 container"
	@echo "  make clean-main-images    - Remove all main project images"
	@echo "=============================================================="