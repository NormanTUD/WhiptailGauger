# WhiptailGauger

Easily use whiptail --gauge for almost any type of program.

Turn this:

![Screenshot](from.png?raw=true "Screenshot")

Into this automatically:

![Screenshot](to.png?raw=true "Screenshot")

# Modifications for your program

Disable line-buffer to print lines immidiately. Then print to stderr (warn) things like that:

```console
PERCENTGAUGE: 10
GAUGESTATUS: Loading module ...
```

`PERCENTGAUGE` is the percentage shown, `GAUGESTATUS` is, if available, printed behind the loading message and updated as soon as it's printed.

# gaugecommand

```console
gaugecommand "$TITLE" "$LOADING_TEXT" "$COMMAND"
```

Set `DISPLAYGAUGE=0` to disable gauge automatically.

# Example

See the `example.sh` on how to use this.
