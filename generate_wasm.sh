#!/bin/bash

DIR=`pwd`

cd tree-sitter-markdown/tree-sitter-markdown
tree-sitter generate --abi 15
tree-sitter build --wasm
mkdir -p $DIR/queries/markdown
cp queries/* $DIR/queries/markdown/
cp tree-sitter-markdown.wasm $DIR
cd $DIR

cd tree-sitter-markdown/tree-sitter-markdown-inline
tree-sitter generate --abi 15
tree-sitter build --wasm
mkdir -p $DIR/queries/markdown-inline
cp queries/* $DIR/queries/markdown-inline/
cp tree-sitter-markdown_inline.wasm $DIR
cd $DIR

cd tree-sitter-mim
tree-sitter generate --abi 15
tree-sitter build --wasm
cp tree-sitter-mim.wasm $DIR
mkdir -p $DIR/queries/mim
cp queries/* $DIR/queries/mim/
cd $DIR

