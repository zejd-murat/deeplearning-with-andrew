{ pkgs, ... }:

{
  # Project metadata
  name = "latex-document-project";

  # Environment packages
  packages = with pkgs; [
    # LaTeX environment with all required packages
    (texlive.combine {
      inherit (texlive)
        scheme-medium
        biblatex-ieee    # IEEE citation style
        pgf              # For Gantt charts
        pgfgantt         # Gantt chart package
        fancyhdr
        listings
        todonotes        # For review notes
        wrapfig          # Figure wrapping
        multirow         # Table formatting
        hyperref         # PDF links
        geometry         # Page layout
        tocloft          # TOC customization
        titlesec         # Section formatting
        enumitem         # List customization
        microtype        # Typography improvements
        mlmodern         # Modern font
        xcolor           # Color support
        csquotes         # Context sensitive quotation
        latexmk          # Build automation
        biber            # Bibliography processor
        tcolorbox        # Added tcolorbox package
        environ          # Required by tcolorbox
        trimspaces       # Required by tcolorbox
        etoolbox         # Required by tcolorbox
        varwidth         # Required for tcolorbox breakable feature
        
        # Add the tcolorbox libraries
        collection-latexextra  # This includes tcolorbox and its libraries
        ;
    })
    
    # Additional tools
    gnused
    
    # For diagram generation
    graphviz         # ER diagrams
    plantuml         # UML diagrams
  ];

  # Scripts for common tasks
  scripts = {
    build.exec = "pdflatex main.tex && pdflatex main.tex";
    build-clean.exec = "pdflatex main.tex && pdflatex main.tex && rm -f *.aux *.log *.toc *.out *.fdb_latexmk *.fls *.run.xml *.bcf *.blg *.bbl *.dvi";
    clean.exec = "rm -f *.aux *.log *.toc *.out *.fdb_latexmk *.fls *.run.xml *.bcf *.blg *.bbl *.dvi *.pdf";
    watch.exec = "latexmk -pdf -pvc main.tex";
  };

  # Environment variables
  env = {
    TEXMFHOME = ".texmf";
    TEXMFVAR = ".texmf-var";
    TEXMFCONFIG = ".texmf-config";
  };
}



