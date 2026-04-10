# ─────────────────────────────────────────────────────────────────
# macro:hook/on_eat
# Fires when a player eats food.
# Based on the consume_item advancement (1.20.5+).
#
# USAGE:
# function macro:hook/bind {event:"eat",func:"mypack:on_eat"}
# ─────────────────────────────────────────────────────────────────
$function macro:hook/bind {event:"eat",func:"$(func)"}
