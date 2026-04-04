# macro:rate_limit/tick — her tick çalışır, player_systems'dan çağrılır

# Cooldown'ları 1 azalt
scoreboard players remove @a[scores={macro.rl_cd=1..}] macro.rl_cd 1

# Global saniye sayacı
scoreboard players add #rl_timer macro.rl_cd 1

# 20 tick = 1 saniye → counter sıfırla
execute if score #rl_timer macro.rl_cd matches 20.. run scoreboard players set @a macro.rl_count 0
execute if score #rl_timer macro.rl_cd matches 20.. run scoreboard players set #rl_timer macro.rl_cd 0
