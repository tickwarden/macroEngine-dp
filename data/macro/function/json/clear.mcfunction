# ─────────────────────────────────────────────────────────────────
# macro:json/clear
# Removes all keys from a named JSON object (object itself survives).
#
# INPUT  (storage macro:input):
#   obj  → object name (string)
#
# OUTPUT:
#   macro.json.rc $rc → 0: cleared  |  2: object not found
# ─────────────────────────────────────────────────────────────────

scoreboard players set $rc macro.json.rc 2

function macro:json/internal/clear_exec with storage macro:input {}
