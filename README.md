# BashBall
Tool for creating self-contained executable multi-file script.

Add bashball to `/bin`, usage`bashball <scripts> > out.bb`.

To run simply do `bash out.bb`.

NOTE: there MUST be a file named main.sh in the root of the .bb file.

Limitation: bash scripts cannot use `. <file>` to import other scripts, they must use `source`.
