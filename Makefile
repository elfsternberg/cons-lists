.PHONY: test

# docs: $(patsubst %.md,%.html,$(wildcard *.md))

%.html: %.md header.html footer.html
	cat header.html > $@
	pandoc $< >> $@
	cat footer.html >> $@

node_modules: package.json
	mkdir -p node_modules
	npm install

test: node_modules
	@node_modules/.bin/mocha --compilers coffee:coffee-script/register

