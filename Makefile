PROJECT := $(shell basename $$PWD)
IMAGE := ${PROJECT}_dev
CONTAINER := ${PROJECT}
BASE_IMAGE := $(shell docker images -q ${IMAGE}:latest)
CONTAINER_CHECK_CMD := docker inspect --type container --format '{{ .State.Running }}' ${CONTAINER} 2>/dev/null | grep true
CONTAINER_RUN_CMD := docker run --name ${CONTAINER} -it --rm -v $(PWD):/opt/project/code ${IMAGE}
CONTAINER_EXEC_CMD := docker exec -it ${CONTAINER}

defaut: dev_shell

rebuild: dev

dev:
	@echo "*** Preparing dev image ***"
	old_id=$$(docker inspect  --format '{{ .ID }}' ${IMAGE}); \
	docker build -t ${IMAGE}:latest --pull=true .; \
	new_id=$$(docker inspect  --format '{{ .ID }}' ${IMAGE}); \
	if [[ "$$old_id" != "$$new_id" ]]; then \
		docker rmi $$old_id || true; \
	fi

dev_init:
ifeq ($(BASE_IMAGE),)
	@make dev
endif

dev_install: dev_init
	if [[ "$$(${CONTAINER_CHECK_CMD})" ]]; then \
		${CONTAINER_EXEC_CMD} bundle install; \
	else \
		${CONTAINER_RUN_CMD} bundle install; \
	fi

dev_shell: dev_init
	if [[ "$$(${CONTAINER_CHECK_CMD})" ]]; then \
		${CONTAINER_EXEC_CMD} sh; \
	else \
		${CONTAINER_RUN_CMD} sh; \
	fi

clean_images:
	docker rmi $$(docker images -q ${IMAGE})

update_license:
	find . -type f -exec /bin/bash -c '\
		if ! grep -q "# Copyright .C. .*$$(date +%Y)" {} ; then \
			sed -i -r "s/(# Copyright .C.) ([0-9]{4}(, [0-9]{4})*) (Szymon Kopciewski)/\1 \2, $$(date +%Y) \4/" {}; \
		fi;' \
	\;

.PHONY: default rebuild dev dev_init dev_install dev_shell clean_images update_license
