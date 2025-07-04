# 🧠 Deep Learning Study Notes

> **Comprehensive Study Notes for Andrew Ng's Deep Learning Course**

## 🛠️ Prerequisites

This project uses **Nix** for reproducible development environment management. You'll need:

- **Nix** (with flakes enabled)
- **direnv** (recommended for automatic environment loading)

## 🚀 Quick Start

2. **Enter the development environment**
   ```bash
   devenv shell
   ```
   
3. **Compile the PDF**
   ```bash
   latexmk -pdf main.tex
   ```

## 📖 Compilation

```bash
# Standard LaTeX compilation chain
pdflatex main.tex && pdflatex main.tex
```

## 📁 Project Structure

```
deeplearning-with-andrew/
├── main.tex              # Main LaTeX document
├── main.pdf              # Generated PDF output
├── devenv.nix            # Nix development environment
├── devenv.lock           # Nix lock file
├── .devenv.flake.nix     # Nix flake configuration
├── README.md             # This file
└── [LaTeX auxiliary files]
```

## 📊 Output

The compilation process generates:
- **main.pdf**: The final formatted study notes
- Various auxiliary files for references, table of contents, etc.
---

**Happy Learning! 🎓**