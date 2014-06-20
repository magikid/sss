BIN = "`scala`"

lib/parser.js: lib/grammar.jison lib/tokens.jisonlex
	${BIN}-bison $^ -o $@

test: lib/parser.scala
	${BIN}/mocha --reporter spec

watch:
	${BIN}/nodemon -x 'make test' -e 'js jison jisonlex' -q

.PHONY: test watch