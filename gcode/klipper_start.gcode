; Script based on an original created by tjjfvi (https://github.com/tjjfvi)
; An up-to-date version of the tjjfvi's original script can be found
; here:  https://csi.t6.fyi/
; Note - This script will only work in Cura V4.2 and above!
; --- Global Settings
; layer_height = {layer_height}
; smooth_spiralized_contours = {smooth_spiralized_contours}
; magic_mesh_surface_mode = {magic_mesh_surface_mode}
; machine_extruder_count = {machine_extruder_count}
; --- Single Extruder Settings
; speed_z_hop = {speed_z_hop}
; retraction_amount = {retraction_amount}
; retraction_hop = {retraction_hop}
; retraction_hop_enabled = {retraction_hop_enabled}
; retraction_enable = {retraction_enable}
; retraction_speed = {retraction_speed}
; retraction_retract_speed = {retraction_retract_speed}
; retraction_prime_speed = {retraction_prime_speed}
; speed_travel = {speed_travel}

; Oliver's Klipper Start G-code
STATUS_HEATING
M117 Waiting for the extruder and bed to get up to temp!
M104 S{material_print_temperature_layer_0}    ;Set Extruder temperature
M140 S{material_bed_temperature_layer_0}      ;Set Heat Bed temperature
M109 S{material_print_temperature_layer_0}    ;Wait for Extruder temperature
M190 S{material_bed_temperature_layer_0}      ;Wait for Heat Bed temperature
G92 E0                           ;Reset Extruder
M117 Homing axes
STATUS_HOMING
G28                              ;Home all axes
G1 Z2.0 F3000                    ;Move Z Axis up little to prevent scratching of Heat Bed
M117 Moving to start position
G1 X4.1 Y20 Z0.3 F5000.0         ;Move to start position
STATUS_CLEANING
M117 Purging
G1 X4.1 Y200.0 Z0.3 F1500.0 E15  ;Draw the first line
G1 X4.4 Y200.0 Z0.3 F5000.0      ;Move to side a little
G1 X4.4 Y20 Z0.3 F1500.0 E30     ;Draw the second line
G92 E0                           ;Reset Extruder
STATUS_PRINTING
M117 Starting print
G1 Z2.0 F3000                    ;Move Z Axis up little to prevent scratching of Heat Bed
G1 X5 Y20 Z0.3 F5000.0           ;Move over to prevent blob squish