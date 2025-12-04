# mlflow-persistence

# ---------------------------------------------------------
# Default Target
# ---------------------------------------------------------

.DEFAULT_GOAL := image

# ---------------------------------------------------------
# Prebuild
# ---------------------------------------------------------

.PHONY: prebuild/deps prebuild/self

# No-op
prebuild/deps:

# No-op
prebuild/self:

# ---------------------------------------------------------
# QA
# ---------------------------------------------------------

.PHONY: qa dev/qa qa/lint dev/qa/lint

qa: qa/lint

dev/qa: dev/qa/lint

dev/qa/lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

# No-op
qa/lint:
	

# Populate with QA targets where needed.

# ---------------------------------------------------------
# Test
# ---------------------------------------------------------

# Populate with Test targets where needed.

# ---------------------------------------------------------
# Image
# ---------------------------------------------------------

.PHONY: image

image:
	docker build -t mobyware/mlflow \
	--build-arg BASE_IMAGE=python \
	--build-arg BASE_IMAGE_TAG=3.12-slim .


.PHONY: image/up

image/up:
	docker run -d --name ml -p 5000:5000 mobyware/mlflow:latest


.PHONY: image/down

image/down:
	docker rm -f ml