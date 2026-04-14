# ─────────────────────────────────────────────────────────────────
# macro:json/export
# Copies an entire named JSON object to an external storage path.
#
# INPUT  (storage macro:input):
#   obj      → source object name (string)
#   storage  → destination storage namespace
#   path     → destination path
#
# OUTPUT:
#   macro.json.rc $rc → 0: success  |  2: object not found
# ─────────────────────────────────────────────────────────────────

scoreboard players set $rc macro.json.rc 2

function macro:json/internal/export_exec with storage macro:input {}
