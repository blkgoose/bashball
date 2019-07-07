.DEFAULT_GOAL := build

bashball := bashball

compile: main.sh optparse/optparse.sh
	@$(bashball) main.sh optparse/optparse.sh

build:
	@echo -n "building... "
	@make -s compile > install.bb
	@echo "done"
