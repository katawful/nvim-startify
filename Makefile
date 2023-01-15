.PHONY: deps compile test

default: deps compile test

deps:
	deps/aniseed/scripts/dep.sh Olical aniseed origin/master
	deps/aniseed/scripts/dep.sh katawful katcros-fnl origin/main

compile:
	rm -rf lua/nvim-startify
	# Remove this if you only want Aniseed at compile time.
	deps/aniseed/scripts/embed.sh aniseed nvim-startify
	# Also remove this embed prefix if you're not using Aniseed inside your plugin at runtime.
	deps/aniseed/scripts/embed.sh katcros-fnl nvim-startify
	# deps/aniseed/scripts/compile.sh
	ANISEED_EMBED_PREFIX=nvim-startify deps/aniseed/scripts/compile.sh

test:
	rm -rf test/lua
	deps/aniseed/scripts/test.sh
