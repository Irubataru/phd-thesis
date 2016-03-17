LATEXMK  := latexmk
LATEX    := xelatex

MAINTEX  := thesis.tex
MAINPDF  := $(MAINTEX:.tex=.pdf)

FIGDIR   := figures
FIGTEX   := $(wildcard $(FIGDIR)/chapter_*/*.tex)
FIGPDF   := $(FIGTEX:.tex=.pdf)

STYLETEX := definitions/colour.tex definitions/lattice_styles.tex

AUXTEX   := $(filter-out $(MAINTEX) $(FIGTEX),$(wildcard **/*.tex))

cd_and_clean = cd $(dir $(realpath $(1))); $(LATEXMK) -C $(notdir $(1))

.PHONY: clean

$(MAINPDF) : $(AUXTEX) $(MAINTEX) $(FIGPDF)
	$(LATEXMK) -pdf $(MAINTEX)

$(FIGPDF): %.pdf: %.tex | $(STYLETEX)
	cd $(dir $<); \
	$(LATEX) $(notdir $<)

clean: $(MAINTEX) $(FIGTEX)
	$(foreach file, $^, $(call cd_and_clean,$(file));)
