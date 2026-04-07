# ─────────────────────────────────────────────────────────────────
# macro:hook/on_fish_caught
# Oyuncu balık tuttuğunda tetiklenir.
# fishing_rod_hooked advancement tabanlı.
#
# INPUT:
#   $(func) veya $(cmd) → tetiklenecek fonksiyon / komut
#   $(tag)              → (opsiyonel) bind etiketi
#
# USAGE:
#   function macro:hook/bind {event:"fish_caught",func:"mypack:on_fish"}
# ─────────────────────────────────────────────────────────────────
$function macro:hook/bind {event:"fish_caught",func:"$(func)"}
