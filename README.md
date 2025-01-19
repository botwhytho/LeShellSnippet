# LeShellSnippet

A custom Lepiter snippet type that runs the string output of Pharo code in the shell. Output from those commands can be used in other snippets in [Glamorous Toolkit](https://gtoolkit.com/).

**2020/01/19 Update**: This repo has been archived. Glamorous Toolkit has had a 'Shell script' snippet for a while now. This repo was an exploration and learning experience on how to create custom snippet types at a time (~2021) when no documentation existed for it.

# Installation

```Smalltalk
Metacello new
    baseline: 'LeShellSnippet';
    repository: 'github://botwhytho/LeShellSnippet:main/src';
    load.
```

# Usage

![LeShellSnippet Basic Usage](../assets/LeShellSnippet-BasicUsage.gif?raw=true)
