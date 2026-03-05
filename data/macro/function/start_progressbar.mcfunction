# ============================================
# Progress Bar — Start
# ============================================
# Usage for health bar:
# /function macro:start_progressbar
#
# To disable:
# /function macro:stop_progressbar
#
# Call with storage for a custom objective:
# data modify storage macro:input pb_obj set value "health"
# data modify storage macro:input max set value 20
# data modify storage macro:input label set value "Health"
# function macro:start_progressbar with storage macro:input {}
# ============================================

# Default: health bar
data modify storage macro:engine pb_obj set value "health"
data modify storage macro:engine pb_max set value 20
data modify storage macro:engine pb_label set value "Health"

# BUG FIX v1.0.6-pre1: Input override — reads from macro:input when provided
# When called with "with storage macro:input {}" these lines
# uses values from macro:input; if not called with storage, hardcoded defaults apply.
execute if data storage macro:input pb_obj run data modify storage macro:engine pb_obj set from storage macro:input pb_obj
execute if data storage macro:input max run data modify storage macro:engine pb_max set from storage macro:input max
execute if data storage macro:input label run data modify storage macro:engine pb_label set from storage macro:input label
