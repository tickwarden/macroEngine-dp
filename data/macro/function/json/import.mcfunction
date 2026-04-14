# ─────────────────────────────────────────────────────────────────
# macro:json/import
# Copies a compound from any storage path into a named JSON object.
# Useful for "parsing" structured data already in storage.
# Type metadata is cleared on import (keys have type=0/unknown).
#
# INPUT  (storage macro:input):
#   obj      → target object name (string)
#   storage  → source storage namespace  (e.g. "macro:engine")
#   path     → source path in that storage (e.g. "player_data.Steve")
#
# OUTPUT:
#   macro.json.rc $rc → 0: success
# ─────────────────────────────────────────────────────────────────

scoreboard players set $rc macro.json.rc 0

function macro:json/internal/import_exec with storage macro:input {}
