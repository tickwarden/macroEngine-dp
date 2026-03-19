# ─────────────────────────────────────────────────────────────────
# macro:nbt/copy
# İki storage arasında veya aynı storage içinde path kopyalar.
#
# INPUT (storage macro:input):
#   src_storage → kaynak storage namespace (örn: "macro:engine")
#   src_path    → kaynak NBT path (örn: "players.Steve")
#   dst_storage → hedef storage namespace
#   dst_path    → hedef NBT path
#
# ÖRNEK:
#   data modify storage macro:input src_storage set value "macro:engine"
#   data modify storage macro:input src_path set value "players.Steve"
#   data modify storage macro:input dst_storage set value "mypack:data"
#   data modify storage macro:input dst_path set value "backup.Steve"
#   function macro:nbt/copy
# ─────────────────────────────────────────────────────────────────

function macro:nbt/internal/copy_exec with storage macro:input {}
