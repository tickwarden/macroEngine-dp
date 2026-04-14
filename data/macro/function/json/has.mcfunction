# ─────────────────────────────────────────────────────────────────
# macro:json/has
# Checks whether a key exists in a named JSON object.
#
# INPUT  (storage macro:input):
#   obj  → object name  (string)
#   key  → dot-path key (string)
#
# OUTPUT:
#   macro:output result   → 1b (exists) or 0b (not found)
#   macro.json.rc  $rc    → 0: found  |  1: key not found  |  2: obj not found
# ─────────────────────────────────────────────────────────────────

scoreboard players set $rc macro.json.rc 2
data modify storage macro:output result set value 0b

function macro:json/internal/has_exec with storage macro:input {}
