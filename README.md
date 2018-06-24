# BashBall
Tool for creating self-contained executable multi-file script.

Add ##### bashball ###### to `/bin`, usage `bashball <scripts> > out.bb`.

To run simply do `bash out.bb`.

##### WARNING :
+  There MUST be a file named `main.sh` in the root of the `.bb` file.
+  Bash scripts cannot use `. <file>` to import other local scripts, they must use `source` or `. $_tmpdir/<file>`
