# dia2pdf

`dia2pdf` is a dia to pdf command line tool.

This is a clone of https://git.framasoft.org/Gwendal/helpful-scripts/blob/master/jshell/dia2pdf.jsh (by @ebousse) in Haskell.

## Dependencies
### Build

https://haskellstack.org/ `stack` tool is required to build the project.

No precompiled version are released for now.

**Building**:
```bash
$ stack build
```

**Run**
```bash
$ stack exec dia2pdf-exe -- $DIAFILE
```

### Runtime

The conversion of a dia file to pdf required two commands.
The `dia` command is provided by http://dia-installer.de/
The `inkscape` command is provided by https://inkscape.org/en/.

For now the external commands are expected to be found in the `PATH`.
