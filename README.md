# BashBall
Tool for creating self-contained executable multi-file script.

Add `bashball` to `/bin`, usage `bashball <scripts> > out.bb`.

To run simply do `bash out.bb`.

## IMPORTS :
+  To use imports, functions must be declared using `function <name>` statements.
+  To import functions from files use `import "<file>" as "<alias>"`, functions will be under the namespace `<alias>`.
+  i.e. `import "test" as "T"; T.run`

##### WARNING :
+  There MUST be a file named `main.sh` in the root of the `*.bb` file.
+  Use `source <file>` for internal files (i.e. files in the `*.bb`) or `. <file>` for local files (i.e. where the `*.bb` is being launched from).
