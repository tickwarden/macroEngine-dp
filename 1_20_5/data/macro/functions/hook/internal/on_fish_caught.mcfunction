# macro:hook/internal/on_fish_caught
# @s = fishing player — advancement reward
scoreboard players add @s macro.hook_fish 1
advancement revoke @s only macro:hook/fish_caught
