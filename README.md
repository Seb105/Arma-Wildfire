# Wildfire!
<img src="https://github.com/Seb105/Arma-Wildfire/blob/main/images/20211104135115_1.jpg?raw=true" alt="Seb's Briefing Table" style="display: block; text-align: center">

This mod adds scripted fire spreading from foliage to foliage, and optionally buildings.

Fires do damage, and are affected by wind direction, speed and rain.

Fires can be started via module or script, and all fires can be extinguished in an emergency. 

The performance FPS wise is better than you'd expect, but less than perfect.

### FEATURES:
- Spreadable wildfire
- Compatible with any modded map
- Eden/Zeus modules
- Takes rain, wind direction and wind strength into account
- Damages AI and players
- ACE Medical Compatible (no compats needed)
- CBA Settings for behaviour and performance
- Optionally burn buildings
- Emergency extinguish module
- Multiplayer compatible
- Serverside calculations


### HOW TO USE:

You can  use the provided modules, accessible via both 3DEN and Zeus.
The module can be activated via synced trigger.

Fires can also be started via script (see examples).

The fire spreading parameters can be adjusted via CBA settings
<img src="https://github.com/Seb105/Arma-Wildfire/blob/main/images/20211104134920_1.jpg?raw=true">

### SCRIPT EXAMPLES

Start a fire (needs to be executed globally)

`_tree remoteExecCall ["wildfire_main_fnc_fire"]`

Emergency stop all fires (needs to be executed on server):

`0 remoteExecCall ["wildfire_main_fnc_emergencyStop", 2]`

## Please submit any contributions, bug reports, stringtable translations, or feature requests to this projects Github:

https://github.com/Seb105/Arma-Wildfire

Licensed under GPLv2

______

## Looking for an Arma community? Check CNTO out:

https://www.carpenoctem.co/

https://www.youtube.com/watch?v=QE8tMdhDYjI
