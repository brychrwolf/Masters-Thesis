STIME = date '+%s' > $@_time
ETIME = read st < $@_time ; echo make recipe completed in $$((`date '+%s'`-$$st)) seconds ; rm -f $@_time

all: svgs tikzs plots thesis presentation

thesis: plots
	$(STIME)
	pdflatex --no-pdf thesis
	makeindex thesis
	makeindex thesis.nlo -s nomencl.ist -o thesis.nls
	makeglossaries thesis
	bibtex thesis
	pdflatex --no-pdf thesis
	pdflatex thesis
	$(ETIME)

once:
	pdflatex thesis

cleanThesis:
	rm -f thesis.aux thesis.bbl thesis.blg thesis.dvi thesis.idx thesis.ilg thesis.ind thesis.lof thesis.log thesis.lot thesis.out thesis.pdf thesis.toc thesis.loa thesis.nlo thesis.nls thesis.tdo thesis.xdv

cleanChapters:
	rm -f chapters/*.aux

cleanNom:
	rm -f thesis.nl*



.PHONY: svgs
svgs:
	cd figures/inkscape && $(MAKE)

cleanSvgs:
	cd figures/inkscape && make clean



.PHONY: tikzs
tikzs:
	cd figures/tikz && $(MAKE)

cleanTikzs:
	cd figures/tikz && make clean



.PHONY: plots
plots:
	cd figures/gnuplot && $(MAKE)

cleanPlots:
	cd figures/gnuplot && make clean



.PHONY: presentation
presentation:
	cd figures/inkscape && $(MAKE) presentation
	cd presentation && $(MAKE)

cleanPresentation:
	cd figures/inkscape && $(MAKE) cleanPresentation
	cd presentation && make clean


clean: cleanThesis

cleanAll: cleanThesis cleanChapters cleanPlots cleanSvgs cleanPresentation

