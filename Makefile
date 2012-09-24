TARGETS = init.js 3dstarf.js

.PHONY: all clean

all: $(TARGETS)

%.js : %.coffee
	coffee -c $<

%.css : %.less
	lessc $< > $@

clean:
	rm -rf $(TARGETS)
