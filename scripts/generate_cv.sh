#!/bin/bash
set -e

# Directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$SCRIPT_DIR/.."
LATEX_DIR="$PROJECT_ROOT/latex"
STATIC_DIR="$PROJECT_ROOT/static"

# Output filename
OUTPUT_FILENAME="RODRIGO_ALMEIDA_CV.pdf"
OUTPUT_PDF="$STATIC_DIR/$OUTPUT_FILENAME"
LATEX_FILE="$LATEX_DIR/cv.tex"

# Get current timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M")

# Create a temporary output directory for compilation
# This ensures auxiliary files don't clutter the source directory
OUTPUT_DIR=$(mktemp -d)

echo "Generating CV from $LATEX_FILE..."

# Compile LaTeX to PDF with timestamp definition
# Pass the timestamp macro to LaTeX
# Run twice for references/layout
pdflatex -jobname="RODRIGO_ALMEIDA_CV" -output-directory="$OUTPUT_DIR" "\def\cvtimestamp{$TIMESTAMP} \input{$LATEX_FILE}" > /dev/null
pdflatex -jobname="RODRIGO_ALMEIDA_CV" -output-directory="$OUTPUT_DIR" "\def\cvtimestamp{$TIMESTAMP} \input{$LATEX_FILE}" > /dev/null

# Move PDF to static folder
if [ -f "$OUTPUT_DIR/RODRIGO_ALMEIDA_CV.pdf" ]; then
    mv "$OUTPUT_DIR/RODRIGO_ALMEIDA_CV.pdf" "$OUTPUT_PDF"
    echo "Success! CV generated at $OUTPUT_PDF"
else
    echo "Error: RODRIGO_ALMEIDA_CV.pdf not found after compilation in "$OUTPUT_DIR"."
    # Cleanup temporary directory
    rm -rf "$OUTPUT_DIR"
    exit 1
fi

# Cleanup temporary directory
rm -rf "$OUTPUT_DIR"

echo "Done."
