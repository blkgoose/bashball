# bashball
Tool for creating self-contained executable multi-file script.

### How to install:
#### Automatically:
+ Run
```bash
bash <(curl -L 'https://blkgoose.github.io/bashball/')
```
It will install bashball on /bin/bashball, to change behaviour, see `--help`:
```bash
bash <(curl -L 'https://blkgoose.github.io/bashball/') --help
```

#### Manually:
+ Download [bashball](https://github.com/blkgoose/bashball/releases/latest/download/bashball)
+ Add `bashball` to `/bin`.

### Usage:
##### Build:
```bash
bashball main.sh .. <other_scripts> > out.bb
```

To run simply do `bash out.bb`.

#### Run scripts during developement:
```bash
bash <(bashball main.sh .. <other_scripts>)
```

### Extract script from bashball
Use `bashball -d <file> > <file>.tar` to extract the sources of a bashball script in a tar file.

### Edit bashball in place
`bashball -e <file.bb>` will open your default editor to edit the compiled source. (editor __MUST__ support tar editing, like ViM)

##### WARNING :
+  There __MUST__ be a file named `main.sh` in the root of the `*.bb` file.
+  Use `source <file>` for internal files (i.e. files in the `*.bb`) or `. <file>` for local files (i.e. where the `*.bb` is being launched from).
