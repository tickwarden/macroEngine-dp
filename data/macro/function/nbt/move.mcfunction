# ─────────────────────────────────────────────────────────────────
# macro:nbt/move
# Aynı storage içinde path'i taşır (kopyala + sil).
#
# INPUT (storage macro:input):
#   storage   → storage namespace
#   from_path → kaynak path
#   to_path   → hedef path
# ─────────────────────────────────────────────────────────────────

function macro:nbt/internal/move_exec with storage macro:input {}
