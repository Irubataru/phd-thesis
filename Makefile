LATEXMK  := latexmk

MAINTEX  := thesis.tex
MAINPDF  := $(MAINTEX:.tex=.pdf)

FIGDIR   := figures
FIGTEX   := $(wildcard $(FIGDIR)/chapter_*/*.tex)
FIGPDF   := $(FIGTEX:.tex=.pdf)

COLTEX   := definitions/colour.tex

AUXTEX   := $(filter-out $(MAINTEX) $(FIGTEX),$(wildcard **/*.tex))

.PHONY: clean

$(MAINPDF) : $(AUXTEX) $(MAINTEX) $(FIGPDF)
	$(LATEXMK) -pdf $(MAINTEX)

$(FIGPDF): %.pdf: %.tex | $(COLTEX)
	cd $(dir $<); \
	$(LATEXMK) -pdf $(notdir $<)

clean: $(MAINTEX) $(FIGTEX)
	$(foreach file, $^, $(LATEXMK) -C $(file);)
