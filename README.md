# bashball
Tool for creating self-contained executable multi-file script.

### How to install:
+ Download [bashball](https://github.com/blkgoose/bashball/releases/latest/download/bashball)
+ Add `bashball` to `/bin`.

### Usage:
##### Build:
```bash
bashball main.sh .. <other_scripts> > out.bb
```

#### Run scripts during developement:
```bash
bash <(bashball main.sh .. <other_scripts>)
```

To run simply do `bash out.bb`.

### Extract script from bashball
Use `bashball -d <file> > <file>.tar` to extract the sources of a bashball script in a tar file.

##### WARNING :
+  There __MUST__ be a file named `main.sh` in the root of the `*.bb` file.
+  Use `source <file>` for internal files (i.e. files in the `*.bb`) or `. <file>` for local files (i.e. where the `*.bb` is being launched from).
