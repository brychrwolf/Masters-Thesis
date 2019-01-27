all: plots thesis

thesis: plots
	xelatex thesis
	makeindex thesis
	bibtex thesis
	xelatex thesis
	xelatex thesis

once:
	xelatex thesis



.PHONY: plots
plots:
	cd plots && $(MAKE)

cleanPlots:
	cd plots && make clean



clean: cleanThesis

cleanAll: cleanThesis cleanPlots

cleanThesis:
	rm -f thesis.aux thesis.bbl thesis.blg thesis.dvi thesis.idx thesis.ilg thesis.ind thesis.lof thesis.log thesis.lot thesis.out thesis.pdf thesis.toc

