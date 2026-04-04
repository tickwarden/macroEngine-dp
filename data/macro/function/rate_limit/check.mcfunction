# macro:rate_limit/check
# Counts this call as one action and checks if the player is rate limited.
# Context: @s = player
# Returns: 1 = blocked (rate limited), 0 = allowed

# Cooldown aktifse direkt blokla, sayma
execute if score @s macro.rl_cd matches 1.. run return 1

# Bu aksiyonu say
scoreboard players add @s macro.rl_count 1

# Limit aşıldıysa cooldown başlat ve counter sıfırla
execute if score @s macro.rl_count >= #rl_limit macro.rl_count run scoreboard players operation @s macro.rl_cd = #rl_cd macro.rl_cd
execute if score @s macro.rl_count >= #rl_limit macro.rl_count run scoreboard players set @s macro.rl_count 0

execute if score @s macro.rl_cd matches 1.. run return 1
return 0
