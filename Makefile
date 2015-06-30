.PHONY: test

targets = lists.js reduce.js

all: $(targets)

%.js: src/%.coffee
	coffee -c -o . $<

node_modules: package.json
	mkdir -p node_modules
	npm install

test: clean node_modules
	@JUNIT_REPORT_PATH=test-reports.xml JUNIT_REPORT_STACK=1 ./node_modules/.bin/mocha \
		--reporter mocha-jenkins-reporter --compilers coffee:coffee-script/register || true

ltest: node_modules
	@node_modules/.bin/mocha --compilers coffee:coffee-script/register

clean: 
	rm -f $(targets)
