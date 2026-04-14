# ─────────────────────────────────────────────────────────────────
# macro:json/get
# Retrieves a key from a named JSON object.
#
# INPUT  (storage macro:input):
#   obj  → object name  (string)
#   key  → dot-path key (string)
#
# OUTPUT:
#   macro:output result    → the stored value (or "" if not found)
#   macro:json result      → same value (dedicated JSON storage copy)
#   macro.json.rc  $rc     → 0: found  |  1: key not found  |  2: obj not found
#   macro.json.type $type  → 0: unknown | 1:string 2:int 3:float
#                            4:compound  | 5:list   6:byte/bool
# ─────────────────────────────────────────────────────────────────

scoreboard players set $rc macro.json.rc 2
scoreboard players set $type macro.json.type 0
data modify storage macro:output result set value ""
data modify storage macro:json result set value ""

function macro:json/internal/get_exec with storage macro:input {}
