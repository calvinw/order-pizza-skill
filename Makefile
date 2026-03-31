IMAGE     = ghcr.io/calvinw/ai-course-devcontainer:latest
CONTAINER = ai-codespace
WORKSPACE = /workspaces/$(notdir $(PWD))

.PHONY: build run setup shell code stop clean

## Pull image, start container, run setup, drop into shell
up: build run setup shell

## Pull the latest devcontainer image
build:
	docker pull $(IMAGE)

## Start the container with the repo mounted (detached)
run:
	docker run -d \
		--name $(CONTAINER) \
		-e CLAUDE_CODE_DISABLE_VSCODE_EXTENSION=1 \
		-e IS_SANDBOX=1 \
		-v "$(PWD)":$(WORKSPACE) \
		-w $(WORKSPACE) \
		$(IMAGE) \
		sleep infinity

## Run post-create setup inside the running container
setup:
	docker exec $(CONTAINER) bash .devcontainer/post-create.sh

## Open an interactive shell inside the container
shell:
	docker exec -it $(CONTAINER) bash

## Open VS Code attached to the running container
code:
	code --folder-uri "vscode-remote://attached-container+$$(printf '{"containerName":"/$(CONTAINER)"}' | xxd -p | tr -d '\n')/$(WORKSPACE)"

## Stop and remove the container
stop:
	docker stop $(CONTAINER) && docker rm $(CONTAINER)

## Stop, remove, and clean up everything
clean: stop
