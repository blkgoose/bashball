.DEFAULT_GOAL := cleanbuild

build: main.sh
cleanbuild: clean build
	@echo -n "building..."
	@mv main.sh sourceMain.sh
	@sed -e 's <VERSION> XXX ' -e 's <VERSION_DATE> YYYY/MM/dd ' sourceMain.sh > main.sh
	@make -s compile > bashball
	@mv sourceMain.sh main.sh
	@echo "success"

compile: main.sh optparse/optparse.sh
	@bashball main.sh optparse/optparse.sh

clean:
	@rm -f bashball
	@mv -f sourceMain.sh main.sh 2>/dev/null | true
