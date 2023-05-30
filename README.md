# analog-tool-installer-FOSS-script
Shell script for installing basic analog FOSS tools.
The tools include:
- `ngspice`
- `magic`
- `open_pdks` 
- `xschem`

The script is currently still in development, but should be functioning.

### Build Notes
The build and make process of the `open_pdk` install may need to be performed twice, because of an error with `miniconda`.
The make process also takes a lot of time so if no errors ocur, just wait.
It took about four to five hours on my Raspberry Pi 400 with Raspberry Pi OS.
