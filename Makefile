.SUFFIXES:

HTML_TEMPLATES=$(wildcard ./src/*.html.j2)
HTML_TARGETS=$(patsubst ./src/%.html.j2,./build/%.html,$(HTML_TEMPLATES))

.PHONY: help
help:
	cat Makefile | grep -Pzo "(?<=\n)[a-z0-9]+:.*\n(\t#[^\n]+\n)*" | sed 's/\t/  /g'

.PHONY: clean
clean:
	-rm -r ./build/

.PHONY: all
all: static html

.PHONY: html
html: $(HTML_TARGETS) # Render html from j2 templates in src

./build/%.html: ./src/%.html.j2 $(wildcard ./src/lib/*.html.j2)
	mkdir -p ./build/
	j2 --print $< > $@

.PHONY: static
static: # Copy static files
	mkdir -p ./build/
	cp -r ./static/* ./build/
