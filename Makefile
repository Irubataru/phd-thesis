LATEXMK  := latexmk

MAINTEX  := thesis.tex
MAINPDF  := $(MAINTEX:.tex=.pdf)

FIGDIR   := figures
FIGTEX   := $(wildcard $(FIGDIR)/chapter_*/*.tex)
FIGPDF   := $(FIGTEX:.tex=.pdf)

.PHONY: clean

$(MAINPDF) : $(MAINTEX) $(FIGPDF)
	$(LATEXMK) -pdf $(MAINTEX)

$(FIGPDF): %.pdf: %.tex
	cd $(dir $<); \
	$(LATEXMK) -pdf $(notdir $<)

clean: $(MAINTEX) $(FIGTEX)
	$(foreach file, $^, $(LATEXMK) -C $(file);)
