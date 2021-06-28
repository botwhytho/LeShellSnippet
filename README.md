# LeShellSnippet

A custom Lepiter snippet type that runs the string output of Pharo code in the shell. Output from those commands can be used in other snippets in [Glamorous Toolkit](https://gtoolkit.com/).

# Installation

```Smalltalk
Metacello new
    baseline: 'LeShellSnippet';
    repository: 'github://botwhytho/LeShellSnippet:main/src';
    load.
```

# Usage

From the Lepiter snippet dropdown menu select `LeShell`. The result of the Pharo code in this snippet will be converted to a string with `asString` and will be run by the default shell. Click on the Help button on the snippet (the one with a question mark) to learn more.
