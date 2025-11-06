# A wrapper to build gmc docker
#
# __author__: tuan t. pham

DOCKER_SERVICE_NAME ?=neofob/gmc
DOCKER_TAG ?=latest


docker:
	docker build -t $(DOCKER_SERVICE_NAME):$(DOCKER_TAG) .
