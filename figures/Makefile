all: dot pyxplot gnuplot

dot: $(foreach s,$(wildcard dot/*.dot),$(patsubst dot/%.dot,output/%.pdf,$s))

gnuplot: $(foreach s,$(wildcard plots/*.gnu),$(patsubst plots/%.gnu,output/%.pdf,$s))

pyxplot: $(foreach s,$(wildcard plots/*.ppl),$(patsubst plots/%.ppl,output/%.pdf,$s))

output/%.pdf: plots/%.gnu
	@gnuplot $<

output/%.pdf: plots/%.ppl
	@pyxplot $<
	@mv $(subst ppl,pdf,$(notdir $<)) $@
	@pdfcrop $@ $@

output/%.pdf: dot/%.dot
	@dot -T pdf -o$@ $<
	@pdfcrop $@ $@

clean:
	@rm -f output/*

.PHONY: all
