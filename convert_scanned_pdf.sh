#!/bin/bash

INPUT=$(grealpath "$1")
OUTPUT=$(basename "$INPUT" .pdf)_vec.pdf

WORK=$(mktemp -d)
echo $WORK
set -e
pushd $WORK
    pdfimages "$INPUT" img
    for img in img*; do
        pimg=p"$img"
        convert -units PixelsPerInch "$img" \
                -blur 0x1 -level 95x100% -threshold 0.5 "$pimg"
    done
    potrace -b pdfpage -P Letter -M 0 p* -o "$OUTPUT"
    mv "$OUTPUT" $(dirname "$INPUT")
popd
#rm -Rf $WORK 
