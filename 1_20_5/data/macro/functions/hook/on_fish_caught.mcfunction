# ─────────────────────────────────────────────────────────────────
# macro:hook/on_fish_caught
# Fires when a player catches a fish.
# Based on the fishing_rod_hooked advancement (1.20.5+).
#
# USAGE:
# function macro:hook/bind {event:"fish_caught",func:"mypack:on_fish"}
# ─────────────────────────────────────────────────────────────────
$function macro:hook/bind {event:"fish_caught",func:"$(func)"}
