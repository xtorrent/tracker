.PHONY: build debug all

BUILD_IMAGE ?= csuliuming/gko3-compile-env:v0.9

CWD := $(shell pwd)
CONTAINER_NAME := gko3-tracker

DOCKER_RUN_OPTS := \
	--name $(CONTAINER_NAME) \
        --rm \
	--hostname $(CONTAINER_NAME) \
	--volume=/etc/localtime:/etc/localtime:ro \
	--volume=$(CWD):$(CWD) \
	--workdir=$(CWD)

build:
	if docker ps -a | grep -q $(CONTAINER_NAME); then \
            docker start $(CONTAINER_NAME); \
            docker exec $(CONTAINER_NAME) ./build.sh; \
        else \
            docker run $(DOCKER_RUN_OPTS) $(BUILD_IMAGE) ./build.sh; \
        fi

debug:
	if docker ps -a | grep -q $(CONTAINER_NAME); then \
            docker start $(CONTAINER_NAME); \
            docker exec -it $(CONTAINER_NAME) /bin/bash; \
        else \
            docker run -it $(DOCKER_RUN_OPTS) $(BUILD_IMAGE) /bin/bash; \
        fi

all: build
