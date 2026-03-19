# ─────────────────────────────────────────────────────────────────
# macro:nbt/pop
# List'in ilk elemanını macro:output result'a kopyalar ve listeden siler.
#
# INPUT (storage macro:input):
#   storage → storage namespace
#   path    → list path
#
# OUTPUT: macro:output result (popped element)
# ─────────────────────────────────────────────────────────────────

function macro:nbt/internal/pop_exec with storage macro:input {}
