DOCUMENT ?= document
WATCH_FILES ?= $(DOCUMENT).tex $(wildcard pages/*.tex) $(wildcard chapters/*.tex)
REFERENCES ?= references.bib

# Replace special chars
REPLACE := s/å/\\aa{}/g;s/Å/\\AA{}/g;s/ä/\\"{a}/g;s/Ä/\\"{A}/g;s/ö/\\"{o}/g;s/Ö/\\"{O}/g;s/\([^\]\)&/\1\\\&/g
REPLACE_QUOTED := s/é/\\\'{e}/g

# Default to a fast pdf compilation
all: document

# Can't be file rule as modifications are done in partial files.
document: $(DOCUMENT).tex
	@pdflatex $<

# Make sure everything is compiled
full: figures document bibtex document document

# Generate bibliography
bibtex: $(DOCUMENT)
	@sed -i '$(REPLACE)' $(REFERENCES)
	@sed -i "$(REPLACE_QUOTED)" $(REFERENCES)
	@bibtex $<

# Generate figures
figures:
	@$(MAKE) -s -C figures/ all

## File watcher -------------------------------------------------------------

# Recompile on file save
watch: $(WATCH_FILES)
	@node -e "\
		var fs = require('fs'), exec = require('child_process').exec;\
		'$^'.split(' ').forEach(function(f) {\
			fs.watchFile(f, exec.bind(exec, 'make -s refresh', function(err, stdout, stderr) {\
				console.log(stdout);\
				console.log(stderr);\
			}));\
		});\
	"

# Kill the watch process. Use echo -n to run the rule even though it does nothing.
kill-watch:
	@echo -n $(shell pid=$$(ps aux \
		| \grep -e "node -e.*$(WATCH_FILES)" \
		| \grep -v "grep -e node -e.*$(WATCH_FILES)" \
		| awk -F ' ' '{print $$2}'); \
		[[ $$pid ]] && kill $$pid \
	)

# Rule to run on recompilation
refresh: all

## PDF viewer ---------------------------------------------------------------

# Restart the pdf viewer for when it crashed
show: kill open

# Open the pdf
open: $(DOCUMENT).pdf
	@open $< &

# Kill the pdf viewer process
kill: $(DOCUMENT).pdf
	@echo -n $(shell pid=$$(ps aux \
		| \grep -e "$<$$" \
		| \grep -v "grep -e $<$$" \
		| awk -F ' ' 'BEGIN {ORS=" "} {print $$2}'); \
		[[ $$pid ]] && kill $$pid \
	)

## Misc ---------------------------------------------------------------------

clean:
	@rm -f *.aux *.bbl *.blg *.lof *.lot *.log *.toc *.lol *.pdf
	@$(MAKE) -s -C figures clean

.PHONY: all figures clean
