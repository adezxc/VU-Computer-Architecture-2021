#!/usr/bin/env bash 
nasm -f macho64 -F dwarf $1.asm -o $1.o -l $1.lst
/usr/bin/clang -g $2.c $1.o -o $2f 
