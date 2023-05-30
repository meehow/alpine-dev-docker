APORTSDIR ?= $(abspath ../aports)

run: deps abuild
	docker run --rm \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ${APORTSDIR}:/aports \
	-e APORTSDIR=/aports \
	-e DISPLAY=${DISPLAY} \
	-it abuild

abuild:
	docker build -t abuild \
		--build-arg http_proxy \
		--build-arg UID=$(shell id -u) .

deps:
	test -e ${APORTSDIR} || git clone https://gitlab.alpinelinux.org/alpine/aports.git ${APORTSDIR}

.PHONY: run abuild deps
