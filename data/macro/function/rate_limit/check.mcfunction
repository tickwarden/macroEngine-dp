# macro:rate_limit/check
# Returns: 1 = rate limited, 0 = OK
# Calling this function counts as one action.

# Admin bypass
execute if entity @s[tag=macro.rl_bypass] run return 0

# Already in cooldown
execute if score @s macro.rl_cooldown matches 1.. run return 1

# Init max
execute unless score @s macro.rl_max matches 1.. run scoreboard players operation @s macro.rl_max = #rl_max_per_sec macro.rl_max

# Count this action
scoreboard players add @s macro.rl_counter 1

# Limit exceeded — set cooldown directly, no sub-functions
execute if score @s macro.rl_counter >= @s macro.rl_max run scoreboard players add @s macro.rl_violations 1
execute if score @s macro.rl_counter >= @s macro.rl_max run scoreboard players operation @s macro.rl_cooldown = #rl_cooldown_1 macro.rl_max
execute if score @s macro.rl_counter >= @s macro.rl_max run scoreboard players set @s macro.rl_counter 0

execute if score @s macro.rl_cooldown matches 1.. run return 1
return 0
