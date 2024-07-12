# Filegen - File generator for testing

Filegen is a simple file generator.
The main use of this application is testing ransomware protection.

### Usage
```bash
fgen [command] [params] path

Commands:
  -f, --file <num>                     Create <num> of dummy files
  -p, --pattern <patternname>          Use <pattername> instead of the default file extendion
  -r, --random                         Generate randomly known patterns
  -i, --interval                       Interval in millisecond between file creation and deleting
  -v  --verbose                        Show verbose information
  -d                                   Delete all created files

```


### Example - Generate 1000 file as fast as possible to the folder /path-to-write
```bash
fgen -f 1000 /path-to-write
```
This will generate 1000 file with the default extention *.fgen in the folder /path-to-write
```bash
fgen_0abe0050b09ae16e.fgen
fgen_1066a6945eae26d7.fgen
fgen_1d940b495e53e70c.fgen
fgen_37f9ba288348acd0.fgen
fgen_87e9bbe39af7bfdd.fgen
fgen_8d3ea32e1c06a501.fgen
...
```
