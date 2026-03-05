# ============================================
# macro:team/create
# ============================================
# Creates a new team and saves it to storage.
# INPUT: macro:input { team:"<name>" }
# OUTPUT: —
#
# For color and display: macro:team/set_color, set_display
# If already present,: team add sviantly fails (guvenli).
# ============================================

$team add $(team)
# BUG FIX v1.0.6-pre1: friendly_fire is now stored as string "true".
# Onceden 1b (bool) writeiliyordu; set_friendly_fire "$(value)" string writeiyordu.
# Both are for storage purposes — the Minecraft team command accepts either.
# Using the same format (string) as set_friendly_fire for consistency.
$data modify storage macro:engine teams.$(team) set value {color:"white",friendly_fire:"true",see_friendly_invisibles:"false"}
$tellraw @a[tag=macro.debug] [{"text":"[Team] Created: ","color":"aqua"},{"text":"$(team)","color":"white"}]
