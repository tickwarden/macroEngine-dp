# ─────────────────────────────────────────────────────────────────
# macro:json/create
# Creates an empty named JSON object. No-op if it already exists.
#
# INPUT  (storage macro:input):
#   obj  → object name (string)
#
# OUTPUT:
#   macro.json.rc $rc → 0: created or already exists
# ─────────────────────────────────────────────────────────────────

scoreboard players set $rc macro.json.rc 0

function macro:json/internal/create_exec with storage macro:input {}
