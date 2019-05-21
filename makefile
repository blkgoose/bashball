.DEFAULT_GOAL := build

build: main.sh
	@echo -n "building..."
	@mv main.sh sourceMain.sh
	@sed -e 's <VERSION> XXX ' -e 's <VERSION_DATE> YYYY/MM/dd ' sourceMain.sh > main.sh
	@make -s compile > bashball
	@mv sourceMain.sh main.sh
	@echo "success"

compile: main.sh optparse/optparse.sh
	@bashball main.sh optparse/optparse.sh
