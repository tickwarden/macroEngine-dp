# ─────────────────────────────────────────────────────────────────
# macro:hook/bind
# Belirli bir event'e fonksiyon veya komut bağlar.
# Aynı event'e birden fazla bind eklenebilir.
#
# INPUT (storage macro:input):
#   event → event adı: "player_join" | "player_death" | "player_respawn"
#            "level_up" | "block_place" | "block_break" | "item_use"
#   func  → (opsiyonel) çalışacak fonksiyon — as tetiklenen oyuncu
#   cmd   → (opsiyonel) çalışacak komut — func yoksa kullanılır
#
# ÖRNEK:
#   data modify storage macro:input event set value "player_death"
#   data modify storage macro:input func set value "mypack:on_death"
#   function macro:hook/bind
# ─────────────────────────────────────────────────────────────────

function macro:hook/internal/bind_exec with storage macro:input {}
