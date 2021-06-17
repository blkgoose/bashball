.DEFAULT_GOAL := cleanbuild

VERSION := $(shell grep '\"version\":' package.json | cut -d':' -f2 | grep -oP '(\d+\.){2}\d+')

init:
	@git config core.hooksPath .githooks
	@git submodule update --init

cleanbuild: init clean build

build: main.sh package.json
	@echo -n "building..."
	@mv main.sh sourceMain.sh
	@sed -e "s <VERSION> $(VERSION) " sourceMain.sh > main.sh
	@make -s compile > bashball
	@mv sourceMain.sh main.sh
	@echo "success"

compile: main.sh optparse/optparse.sh
	@bashball main.sh optparse/optparse.sh

clean:
	@rm -f bashball
	@mv -f sourceMain.sh main.sh 2>/dev/null | true
