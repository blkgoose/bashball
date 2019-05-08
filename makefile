.DEFAULT_GOAL := build

build:
	@echo -n "building..."
	@make -s compile > bashball
	@echo "success"

compile: main.sh optparse/optparse.sh
	@bashball main.sh optparse/optparse.sh
