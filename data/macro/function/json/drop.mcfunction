# ─────────────────────────────────────────────────────────────────
# macro:json/drop
# Deletes an entire named JSON object (data + metadata).
#
# INPUT  (storage macro:input):
#   obj  → object name (string)
#
# OUTPUT:
#   macro.json.rc $rc → 0: dropped  |  2: object not found
# ─────────────────────────────────────────────────────────────────

scoreboard players set $rc macro.json.rc 2

function macro:json/internal/drop_exec with storage macro:input {}
