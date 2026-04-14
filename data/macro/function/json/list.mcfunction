# ─────────────────────────────────────────────────────────────────
# macro:json/list
# Debug: dumps the full contents of a named JSON object to admins.
#
# INPUT  (storage macro:input):
#   obj  → object name (string)
#
# OUTPUT:
#   macro.json.rc $rc → 0: ok  |  2: object not found
# ─────────────────────────────────────────────────────────────────

scoreboard players set $rc macro.json.rc 2

function macro:json/internal/list_exec with storage macro:input {}
