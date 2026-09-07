.PHONY: test profile

test:
	nvim --headless \
		-u tests/minimal_init.lua \
		-c 'lua dofile("tests/run.lua")'

profile:
	nvim --headless \
		-i NONE \
		--startuptime /tmp/nvi-startuptime.log \
		-c 'quitall'
	awk 'NF { line = $$0 } END { print line }' /tmp/nvi-startuptime.log
