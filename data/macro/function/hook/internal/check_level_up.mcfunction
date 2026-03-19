# macro:hook/internal/check_level_up
# @s oyuncusunun XP level'ını önceki tick ile karşılaştırır.
# Artış varsa on_level_up tetikler.

execute store result score $hlvl_cur macro.tmp run data get entity @s XpLevel
execute if score @s macro.hook_lvl < $hlvl_cur macro.tmp run function macro:hook/internal/on_level_up
execute store result score @s macro.hook_lvl run scoreboard players get $hlvl_cur macro.tmp
