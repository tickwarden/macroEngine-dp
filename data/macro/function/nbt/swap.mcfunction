# ─────────────────────────────────────────────────────────────────
# macro:nbt/swap
# Aynı storage içinde iki path'in değerlerini değiştirir.
#
# INPUT (storage macro:input):
#   storage → storage namespace
#   path_a  → birinci path
#   path_b  → ikinci path
# ─────────────────────────────────────────────────────────────────

function macro:nbt/internal/swap_exec with storage macro:input {}
