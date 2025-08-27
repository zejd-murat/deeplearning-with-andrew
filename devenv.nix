{ pkgs, lib, config, ... }:

{
  languages.python.enable = true;
  languages.python.version = "3.13";
  languages.python.uv.enable = true;
  languages.cplusplus.enable = true;

  # Environment packages
  packages = with pkgs; [
    # C++ runtime libraries - ADD THESE
    gcc-unwrapped.lib
    glibc
    stdenv.cc.cc.lib
    
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

    # CUDA toolkit and libraries
    cudaPackages.cudatoolkit
    cudaPackages.cudnn
    cudaPackages.libcublas
    cudaPackages.libcufft
    cudaPackages.libcurand
    cudaPackages.libcusolver
    cudaPackages.libcusparse
    
    linuxPackages.nvidia_x11
  ];

  env = {
    CUDA_PATH = "${pkgs.cudaPackages.cudatoolkit}";
    CUDA_HOME = "${pkgs.cudaPackages.cudatoolkit}";
    CUDNN_PATH = "${pkgs.cudaPackages.cudnn}";
    # Updated LD_LIBRARY_PATH to include NVIDIA driver libraries AND C++ runtime
    LD_LIBRARY_PATH = "${pkgs.gcc-unwrapped.lib}/lib:${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.cudaPackages.cudatoolkit}/lib:${pkgs.cudaPackages.cudnn}/lib:${pkgs.cudaPackages.libcublas}/lib:${pkgs.cudaPackages.libcufft}/lib:${pkgs.cudaPackages.libcurand}/lib:${pkgs.cudaPackages.libcusolver}/lib:${pkgs.cudaPackages.libcusparse}/lib:${pkgs.linuxPackages.nvidia_x11}/lib";
  };
}

