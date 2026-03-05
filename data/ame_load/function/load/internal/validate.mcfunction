# ============================================
# ame_load:load/internal/validate
# ============================================
# Pre-load prerequisite validation.
# Returns 0 if load should be aborted, 1 on success.
#
# Checks (in order):
#   1) Global storage absent → create it
#   2) Log storage absent → create it (before log/add is called)
#   3) Already-loaded guard (return 0)
#   4) Storage version match check (return 0)
#   5) Scoreboard version conflict check (return 0)
# ============================================

# ─── Global storage init ───────────────────────────────
execute unless data storage macro:engine global run data modify storage macro:engine global set value {version:"V1.0.6-pre1"}

# ─── Log storage init (before log/add is called) ─────
# BUG FIX v1.0.4: Both lines are protected with unless;
# circular buffer corruption prevented.
execute unless data storage macro:engine log_display run data modify storage macro:engine log_display set value []
execute unless score $log_count macro.tmp matches 0.. run scoreboard players set $log_count macro.tmp 0

# ─── Already-loaded guard ────────────────────────────────
# BUG FIX v1.0.4: Guard must come before log entries.
execute if data storage macro:engine global{loaded:1b} run data modify storage macro:input message set value "Already loaded — skipping reload."
execute if data storage macro:engine global{loaded:1b} run function macro:log/warn with storage macro:input {}
execute if data storage macro:engine global{loaded:1b} run return 0

# ─── Storage version check ───────────────────────────────
execute unless data storage macro:engine global{version:"V1.0.6-pre1"} run data modify storage macro:names temp.vers set value "V1.0.6-pre1"
execute unless data storage macro:engine global{version:"V1.0.6-pre1"} run tellraw @a [{"text":"[AME] ","color":"aqua","bold":true},{"text":"Version mismatch — expected ","color":"red"},{"storage":"macro:names","nbt":"temp.vers","color":"yellow"},{"text":".","color":"red"}]
execute unless data storage macro:engine global{version:"V1.0.6-pre1"} run return 0

# ─── Scoreboard version conflict check ───────────────────
# ame.pre_version objective: created here early (safe if already exists).
# $ame_ver_set = 1 means a previous AME session wrote version scores.
# Any mismatch from (1, 0, 5) triggers version_warn and aborts load.
scoreboard objectives add ame.pre_version dummy
scoreboard players set $ver_mismatch ame.pre_version 0
execute if score $ame_ver_set ame.pre_version matches 1 run execute unless score $v_major ame.pre_version matches 1 run scoreboard players set $ver_mismatch ame.pre_version 1
execute if score $ame_ver_set ame.pre_version matches 1 run execute unless score $v_minor ame.pre_version matches 0 run scoreboard players set $ver_mismatch ame.pre_version 1
execute if score $ame_ver_set ame.pre_version matches 1 run execute unless score $v_patch ame.pre_version matches 6 run scoreboard players set $ver_mismatch ame.pre_version 1
execute if score $ame_ver_set ame.pre_version matches 1 run execute unless score $v_pre   ame.pre_version matches 1 run scoreboard players set $ver_mismatch ame.pre_version 1
execute if score $ver_mismatch ame.pre_version matches 1 run function ame_load:load/internal/version_warn
execute if score $ver_mismatch ame.pre_version matches 1 run return 0

return 1
