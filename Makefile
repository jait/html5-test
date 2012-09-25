TARGETS = init.js starfield.js

.PHONY: all clean

all: $(TARGETS)

%.js : %.coffee
	coffee -c $<

%.css : %.less
	lessc $< > $@

clean:
	rm -rf $(TARGETS)
