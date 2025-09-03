# Variables for building images
IMAGE_NAME = dimazyablicev/rails_prepared_ubuntu

run-container:
	docker run \
		-it \
		-v "$(pwd)/../:/app" \
		$(IMAGE_NAME) \
		bash

delete-git:
	@if [ -d ".git" ]; then \
		echo "Удаляю .git..."; \
		rm -rf .git; \
	else \
		echo ".git не найден, пропускаю"; \
	fi

start: delete-git run-container
