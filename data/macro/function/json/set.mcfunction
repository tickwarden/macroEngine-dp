# ─────────────────────────────────────────────────────────────────
# macro:json/set
# Stores a key-value pair in a named JSON object.
#
# INPUT  (storage macro:input):
#   obj   → object name  (string)
#   key   → dot-path key (string)
#   type  → type code int (optional, default 0=unknown)
#             1:string  2:int  3:float  4:compound  5:list  6:byte/bool
#
# INPUT  (storage macro:input value):
#   Any NBT value — set this path to the value you want to store.
#   Example:  data modify storage macro:input value set value 42
#             data modify storage macro:input value set value "hello"
#
# OUTPUT:
#   macro.json.rc $rc → 0: success  |  2: object not found (create it first)
# ─────────────────────────────────────────────────────────────────

execute unless data storage macro:input type run data modify storage macro:input type set value 0
scoreboard players set $rc macro.json.rc 2

function macro:json/internal/set_exec with storage macro:input {}
