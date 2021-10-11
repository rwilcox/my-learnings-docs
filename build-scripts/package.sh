#!/usr/bin/env bash

MARKDOWN_TOC_BIN=~/.npm-packages/bin/markdown-toc

# Step 1: for files that need pre-processing, do that
# ================================================
for file in ./*.md.rkt; do
    echo "processing $file..."
    racket "$file" > $(basename "$file" .rkt)
    # basename like this removes the $2 parameter from the name. Neat.
done

racket README.md.rkt > README.md  # second pass for index


# Step 2: Generate tables of contents
# ===============================================

for file in ./*.md; do
    echo "  * $file"
    $MARKDOWN_TOC_BIN -i $file
done
