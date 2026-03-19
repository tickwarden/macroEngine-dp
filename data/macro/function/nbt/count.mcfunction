# ─────────────────────────────────────────────────────────────────
# macro:nbt/count
# Storage'daki list'in eleman sayısını döndürür.
#
# INPUT (storage macro:input):
#   storage → storage namespace
#   path    → list path
#
# OUTPUT: macro:output result (int)
# ─────────────────────────────────────────────────────────────────

function macro:nbt/internal/count_exec with storage macro:input {}
