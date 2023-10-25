#!/usr/bin/env bash


# MARKDOWN_TOC_BIN=~/.npm-packages/bin/markdown-toc
MARKDOWN_TOC_BIN=/opt/local/bin/markdown-toc
RACKET_BIN=~/Applications/Racket_v8.9/bin/racket

# TODO: make this dynamic
# ^^^^^^^ npm install -g markdown-toc


# Step 1: for files that need pre-processing, do that
# ================================================
for file in ./*.md.rkt; do
    echo "processing $file..."
    $RACKET_BIN "$file" > $(basename "$file" .rkt)
    # basename like this removes the $2 parameter from the name. Neat.
done

$RACKET_BIN README.md.rkt > README.md  # second pass for index


# Step 2: Generate tables of contents
# ===============================================

for file in ./*.md; do
    echo "  * Generating TOC for: $file"
    $MARKDOWN_TOC_BIN -i $file
done

# Ughh trailing whitespace for some reason...
for file in ./*.md; do
    sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' -i '' $file
done
