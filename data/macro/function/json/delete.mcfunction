# ─────────────────────────────────────────────────────────────────
# macro:json/delete
# Removes a key from a named JSON object.
#
# INPUT  (storage macro:input):
#   obj  → object name  (string)
#   key  → dot-path key (string)
#
# OUTPUT:
#   macro.json.rc $rc → 0: deleted  |  1: key not found  |  2: obj not found
# ─────────────────────────────────────────────────────────────────

scoreboard players set $rc macro.json.rc 2

function macro:json/internal/delete_exec with storage macro:input {}
