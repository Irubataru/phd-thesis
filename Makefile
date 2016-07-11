LATEXMK  := latexmk
LATEX    := xelatex

MAINTEX  := thesis.tex
MAINPDF  := $(MAINTEX:.tex=.pdf)

FIGDIR   := figures
FIGTEX   := $(wildcard $(FIGDIR)/chapter_*/*.tex)
FIGPDF   := $(FIGTEX:.tex=.pdf)

PLOTDIR  := plots
PLOTTEX  := $(wildcard $(PLOTDIR)/chapter_*/*.tex)
PLOTPDF  := $(PLOTTEX:.tex=.pdf)

STYLETEX := definitions/colour.tex definitions/lattice_styles.tex

AUXTEX   := $(filter-out $(MAINTEX) $(FIGTEX),$(wildcard **/*.tex))

cd_and_clean = cd $(dir $(realpath $(1))); $(LATEXMK) -C $(notdir $(1))

.PHONY: clean cleanthesis

$(MAINPDF) : $(AUXTEX) $(MAINTEX) $(FIGPDF) $(PLOTPDF)
	$(LATEXMK) -pdf $(MAINTEX)

$(FIGPDF): %.pdf: %.tex | $(STYLETEX)
	cd $(dir $<); \
	$(LATEX) $(notdir $<)

$(PLOTPDF): %.pdf: %.tex | $(STYLETEX)
	cd $(dir $<); \
	$(LATEXMK) -C $(notdir $<); \
	$(LATEXMK) -pdf $(notdir $<)

clean: $(MAINTEX) $(FIGTEX)
	$(foreach file, $^, $(call cd_and_clean,$(file));)

cleanthesis: $(MAINTEX)
	$(LATEXMK) -C $(MAINTEX)
