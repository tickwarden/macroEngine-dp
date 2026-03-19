# ─────────────────────────────────────────────────────────────────
# macro:nbt/append
# Storage'daki list'e başka bir storage path'inden eleman ekler.
#
# INPUT (storage macro:input):
#   dst_storage → hedef storage
#   dst_path    → hedef list path
#   src_storage → kaynak storage
#   src_path    → eklenecek değerin path'i
# ─────────────────────────────────────────────────────────────────

function macro:nbt/internal/append_exec with storage macro:input {}
