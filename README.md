# bashball
Tool for creating self-contained executable multi-file script.

Add `bashball` to `/bin`, usage `bashball <scripts> > out.bb`.

To run simply do `bash out.bb`.

### Extract script from bashball
Use `bashball -d <file>` to extract the sources in the `<file without .bb extention>_dec` folder.

##### WARNING :
+  There MUST be a file named `main.sh` in the root of the `*.bb` file.
+  Use `source <file>` for internal files (i.e. files in the `*.bb`) or `. <file>` for local files (i.e. where the `*.bb` is being launched from).
