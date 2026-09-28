---
name: release
description: Release a new version of the extension - bump the version in package.json/package-lock.json, create a clean bump-version commit, and tag it as vX.Y.Z. Use when the user asks to release, cut, or bump a new version.
argument-hint: "<version, e.g. 0.2.1 | patch | minor | major>"
---

# Release a new version

Target version: `$ARGUMENTS`. If it is empty, ask the user for the version, suggesting the next patch version. `patch`, `minor`, and `major` mean the next version of that kind after the current `version` in package.json.

## 1. Pre-flight checks

- Read the current version: `node -p "require('./package.json').version"`.
- List existing tags with `git tag --list 'v*'`. Stop if `v<version>` already exists.
- Check that the new version is greater than the current one. If package.json already contains the target version (for example because it was bumped by hand), skip the bump in step 2 and still make the commit.
- Run `git status`. The bump commit may contain only `package.json` and `package-lock.json`. Leave any other changes, including modified submodules such as `tree-sitter-markdown`, out of the commit. If files are already staged, ask the user before continuing.

## 2. Bump the version

Run `npm version <version> --no-git-tag-version`. It updates both version fields in `package-lock.json` along with `package.json`, and it does not commit or tag. Then check `git diff package.json package-lock.json`: only the version lines should have changed.

## 3. Commit and tag

```sh
git add package.json package-lock.json
git commit -m "Bump version to <version>"
git tag -a v<version> -m "v<version>"
```

Stage only those two files, never `git add -A` or `git add .`. Attribute the commit only to the acting user, not Claude. Check the result with `git show --stat HEAD`.

Do not push. Pushing is left to the user.

## 4. Tell the user what's next

Finish with these instructions:

1. Push the commit and the tag:
   ```sh
   git push && git push origin v<version>
   ```
   Pushing the tag starts the `Publish` GitHub Actions workflow ([.github/workflows/publish.yml](../../../.github/workflows/publish.yml)). It builds the `.vsix`, creates a GitHub release with the `.vsix` attached, and publishes to Open VSX.
2. After the workflow finishes, download `tree-sitter-mim-vscode-<version>.vsix` from the GitHub release. Upload it by hand to the VS Code Marketplace at https://marketplace.visualstudio.com/manage/publishers/mimirextensions (the `MimIRExtensions` publisher, then "Update" on the extension).
