# ============================================
# macro:load — Advanced Macro Engine v1.0.6-pre1
# ============================================
# Runs automatically on /reload or server start.
# All logic moved to the ame_load modular system.
#
# Modular layout:
#   ame_load:load/internal/validate  — guard + version check
#   ame_load:load/scoreboards        — scoreboard objectives
#   ame_load:load/storages           — storage + counter init
#   ame_load:load/other              — schedule / forceload / trigger
#   ame_load:load/all                — full orchestration
# ============================================

function ame_load:load/all
