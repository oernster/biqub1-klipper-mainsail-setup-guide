; Oliver's Klipper Start G-code
M117 Getting the bed up to temp!
M140 S{material_bed_temperature_layer_0}      ;Set Heat Bed temperature
M190 S{material_bed_temperature_layer_0}      ;Wait for Heat Bed temperature
M117 Getting the extruder up to temp!
M104 S{material_print_temperature_layer_0}    ;Set Extruder temperature
G92 E0                           ;Reset Extruder
M117 Homing axes
G28                              ;Home all axes
M117 Waiting for the extruder to get up to temp!
M109 S{material_print_temperature_layer_0}    ;Wait for Extruder temperature
G1 Z2.0 F3000                    ;Move Z Axis up little to prevent scratching of Heat Bed
M117 Moving to start position
G1 X4.1 Y20 Z0.3 F5000.0         ;Move to start position
M117 Purging
G1 X4.1 Y200.0 Z0.3 F1500.0 E15  ;Draw the first line
G1 X4.4 Y200.0 Z0.3 F5000.0      ;Move to side a little
G1 X4.4 Y20 Z0.3 F1500.0 E30     ;Draw the second line
G92 E0                           ;Reset Extruder
M117 Starting print
G1 Z2.0 F3000                    ;Move Z Axis up little to prevent scratching of Heat Bed
G1 X5 Y20 Z0.3 F5000.0           ;Move over to prevent blob squish
