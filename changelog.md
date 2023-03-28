# Changelog

-   [!]—backward incompatible change
-   [+]—new feature
-   [f]—bugfix
-   [r]—refactoring
-   [t]—test suite improvement
-   [d]—docs improvement


## 1.0.2 (March 28, 2023)

-   [f] Fix invalid Nim version requirement, Nim devel no longer required.


## 1.0.1 (March 6, 2023)

-   [+] Add `defaultHandler` param to `parseCommands` that is called when no match is found.
-   [+] Options that come before the command are collected along with the ones that come after it. I.e. `git flow -d init` is just as valid as `git flow init -d`.


## 1.0.0 (March 1, 2023)

-   🎉 initial release.

