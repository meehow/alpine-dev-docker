APORTS_DIR ?= $(abspath ../aports)

run: deps abuild
	docker run --rm -v ${APORTS_DIR}:/aports \
	-e DISPLAY=${DISPLAY} \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-it abuild

abuild:
	docker build -t abuild \
		--build-arg http_proxy \
		--build-arg UID=$(shell id -u) .

deps:
	test -e ${APORTS_DIR} || git clone https://gitlab.alpinelinux.org/alpine/aports.git ${APORTS_DIR}

.PHONY: run abuild
