# ─────────────────────────────────────────────────────────────────
# macro:nbt/exists
# Storage'da belirli path var mı kontrol eder.
#
# INPUT (storage macro:input):
#   storage → storage namespace
#   path    → kontrol edilecek path
#
# OUTPUT: macro:output result → 1b (var) veya 0b (yok)
# ─────────────────────────────────────────────────────────────────

function macro:nbt/internal/exists_exec with storage macro:input {}
