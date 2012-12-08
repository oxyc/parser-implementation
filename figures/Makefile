all: dot

dot: $(foreach s,$(wildcard dot/*.dot),$(patsubst dot/%.dot,output/%.pdf,$s))

output/%.pdf: dot/%.dot
	@dot -T pdf -o$@ $<
	@pdfcrop $@ $@

clean:
	@rm -f output/*

.PHONY: all
