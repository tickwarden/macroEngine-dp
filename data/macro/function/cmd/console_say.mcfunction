# ─────────────────────────────────────────────────────────────────
# macro:cmd/console_say
# Sends a message to the server console and all players via /say.
# The /say command produces "[SERVER]" prefixed output; visible in
# both console and in-game — useful for datapack debugging.
#
# INPUT:
#   $(message) → text to send
#
# EXAMPLE:
# function macro:cmd/console_say {message:"Hook fired: player_join"}
# # Konsol: [Server] Hook fired: player_join
# ─────────────────────────────────────────────────────────────────

$say $(message)
