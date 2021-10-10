#!/usr/bin/env bash

for file in ./*.md.rkt; do
    echo "processing $file..."
    racket "$file" > $(basename "$file" .rkt)
    # basename like this removes the $2 parameter from the name. Neat.
done
