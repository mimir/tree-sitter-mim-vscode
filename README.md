<p align="center">
    <img src="https://raw.githubusercontent.com/mimir/tree-sitter-mim-vscode/refs/heads/master/icon.png"
        alt="MimIR logo"
        height="200">
</p>

# tree-sitter-mim-vscode

Language support for [Mim](https://github.com/mimir/mimir), the surface language of [MimIR](https://mimir.github.io/), in VS Code, powered by the [tree-sitter-mim](https://github.com/mimir/tree-sitter-mim) grammar.

This extension is a fork of [tree-sitter-vscode](https://github.com/AlecGhost/tree-sitter-vscode) with the Mim grammar and queries bundled, so it works out of the box without any configuration.

## Features

- Semantic highlighting for `.mim` files
- Markdown highlighting inside `///` doc comments (via [tree-sitter-markdown](https://github.com/tree-sitter-grammars/tree-sitter-markdown))
- Folding ranges
- Expand/shrink selection along the syntax tree
- Incremental re-parsing on every edit
- Comment toggling, bracket matching, and auto-closing, including `‹›` and `«»`

## Installation

Build a `.vsix` (see below), then run

```sh
code --install-extension tree-sitter-mim-vscode-<version>.vsix
```

## Configuration

| Setting                                  | Description                                                                                                                                                                                                   |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `tree-sitter-mim-vscode.languageConfigs` | Additional or overriding language configs. Each entry needs `lang`, `parser` (`.wasm`), and `highlights` (`.scm`), and may add `injections`, `folds`, `injectionOnly`, and `semanticTokenTypeMappings`. An entry whose `lang` matches a bundled one (`mim`, `markdown`, `markdown-inline`) replaces it. |
| `tree-sitter-mim-vscode.debug`           | Enable debug logging.                                                                                                                                                                                         |

Paths may use `${extension_dir}` to refer to the installed extension.
Overriding `mim` is handy to try a locally built grammar without repackaging.
Run **tree-sitter-mim-vscode: Reload** after changing the settings.

## Building

Requirements: Node.js with npm, the [tree-sitter CLI](https://tree-sitter.github.io/tree-sitter/creating-parsers/1-getting-started.html) (≥ 0.25, for ABI 15), and either [Emscripten](https://emscripten.org/) or Docker/Podman for `tree-sitter build --wasm`.

```sh
git clone --recursive https://github.com/mimir/tree-sitter-mim-vscode
cd tree-sitter-mim-vscode
npm install
npx vsce package
```

Packaging runs `generate_wasm.sh`, which regenerates the Mim and Markdown parsers from the submodules, compiles them to `.wasm`, and copies their queries into `queries/`.
To pick up a newer grammar, update the `tree-sitter-mim` submodule and repackage.

## License

[Apache-2.0](LICENSE.txt)
