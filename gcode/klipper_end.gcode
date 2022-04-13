;Oliver's Klipper End Gcode
G91                            ;Relative positioning
G1 E-2 F2700                   ;Retract a bit
G1 E-2 Z0.2 F2400              ;Retract a bit more and raise Z
G1 X5 Y5 F3000                 ;Wipe out
M117 Moving print head
G0 Z40 F2500                   ;Print head up
G28 G91 X0                     ;Home only x axis
M117 Turning off fan
M106 S0                        ;Turn-off fan
M117 Turning off hotend
M104 S0                        ;Turn-off hotend
M117 Turning off bed
M140 S0                        ;Turn-off bed
M117 Disabling all steppers but Z
M84 X Y E                      ;Disable all steppers but Z
M117 DONE! Tadaaaaaa!!!
STATUS_READY