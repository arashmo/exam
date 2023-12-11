.PHONY: help build-dev-docker build-product-docker run-dev deploy all clean

BUILD_LOG = build.log

define log_build
	@echo "$(1) on $(shell date)" >> $(BUILD_LOG)
endef

# Help target
help:
	@echo "Available targets:"
	@echo "  build-dev-docker               - Build the Docker image using the script in the docker folder."
	@echo "  local_production-docker        - Run necessary scripts, your local machine will install necessary resources."
	@echo "  deploy                         - Build and Deploy using kustomize."
	@echo "  all                            - Run build, run, and deploy targets."

# Docker build targets
build-dev-docker:
	@if ! grep -q "build-dev-docker" $(BUILD_LOG); then \
		echo "Building Docker image for developer..."; \
		 cd ./docker/developer && ./docker-build.sh && \
		$(call log_build,"build-dev-docker"); \
	else \
		echo "Docker image for developer already built. Skipping..."; \
	fi

build-product-docker:
	@echo "Building Docker image for Service 2..."
	@if ! grep -q "build-production-docker" $(BUILD_LOG); then \
		echo "Building Docker image for developer..."; \
		 cd ./docker/production && ./docker-build.sh && \
		$(call log_build,"build-production-docker"); \
	else \
		echo "Docker image for developer already built. Skipping..."; \
	fi
	

	
