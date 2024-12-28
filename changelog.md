# Changelog

-   [!]—backward incompatible change
-   [+]—new feature
-   [f]—bugfix
-   [r]—refactoring
-   [t]—test suite improvement
-   [d]—docs improvement


## 1.1.3 (December 28, 2024)

-   [+] Add `flag` sugar to capture flags (i.e. options without values).
-   [+] Add `opt` and `flag` variants with a fallback block.
-   [d] Add docsrtings to the sugar templates.


## 1.1.2 (December 4, 2024)

-   [+] Add `arg` and `args` variants that don't require a fallback block.
-   [f] In `arg` and `args`, the main block would get executed after the fallback block. Now, it's either this or that.
-   [r] `missing` argument renamed to `fallback` to avoid collision with Nim's error message.
-   [t] Added commands to git demo app to demonstrate fallback-less `arg` and `args` templates.


## 1.1.1 (July 3, 2024)

-   [f] Fix warning about unused `val` in `sugar` submodule.


## 1.1.0 (July 3, 2024)

-   [!][r] Importing `climate` now imports all submodules including `sugar` and `context`. Just add `import climate` and that's it.
-   [+] Add new demo, Battleship.


## 1.0.3 (April 3, 2023)

-   [+] Add sugar to work with arguments and options to `climate/sugar`.


## 1.0.2 (March 28, 2023)

-   [f] Fix invalid Nim version requirement, Nim devel no longer required.


## 1.0.1 (March 6, 2023)

-   [+] Add `defaultHandler` param to `parseCommands` that is called when no match is found.
-   [+] Options that come before the command are collected along with the ones that come after it. I.e. `git flow -d init` is just as valid as `git flow init -d`.


## 1.0.0 (March 1, 2023)

-   🎉 initial release.

