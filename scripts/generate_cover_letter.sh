#!/bin/bash
set -e

# Directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$SCRIPT_DIR/.."
LATEX_DIR="$PROJECT_ROOT/latex"
STATIC_DIR="$PROJECT_ROOT/static"

# Get current timestamp and date for filename
TIMESTAMP=$(date "+%Y-%m-%d %H:%M")
DATE_FILENAME=$(date "+%Y-%m-%d")

# Output filename with date
OUTPUT_FILENAME="RODRIGO_ALMEIDA_COVER_LETTER_${DATE_FILENAME}.pdf"
OUTPUT_PDF="$STATIC_DIR/$OUTPUT_FILENAME"
LATEX_FILE="$LATEX_DIR/cover_letter.tex"

# Create a temporary output directory for compilation
OUTPUT_DIR=$(mktemp -d)

echo "Generating Cover Letter from $LATEX_FILE..."

# Compile LaTeX to PDF with timestamp definition
# Pass the timestamp macro to LaTeX
pdflatex -jobname="RODRIGO_ALMEIDA_COVER_LETTER" -output-directory="$OUTPUT_DIR" "\def\cvtimestamp{$TIMESTAMP} \input{$LATEX_FILE}" > /dev/null
pdflatex -jobname="RODRIGO_ALMEIDA_COVER_LETTER" -output-directory="$OUTPUT_DIR" "\def\cvtimestamp{$TIMESTAMP} \input{$LATEX_FILE}" > /dev/null

# Move PDF to static folder
# Note: The jobname determines the output filename in the temp dir
if [ -f "$OUTPUT_DIR/RODRIGO_ALMEIDA_COVER_LETTER.pdf" ]; then
    mv "$OUTPUT_DIR/RODRIGO_ALMEIDA_COVER_LETTER.pdf" "$OUTPUT_PDF"
    echo "Success! Cover Letter generated at $OUTPUT_PDF"
else
    echo "Error: RODRIGO_ALMEIDA_COVER_LETTER.pdf not found after compilation in "$OUTPUT_DIR"."
    # Cleanup temporary directory
    rm -rf "$OUTPUT_DIR"
    exit 1
fi

# Cleanup temporary directory
rm -rf "$OUTPUT_DIR"

echo "Done."
