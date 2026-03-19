# macro:hook/internal/tick_scan
# Her tick'te hook event'lerini tespit eder.
# Sadece hook_binds doluysa çalışır.

execute unless data storage macro:engine hook_binds[0] run return 0

# player_join — macro.hook_online score'u olmayan online oyuncu
execute as @a[scores={macro.hook_online=0}] run function macro:hook/internal/on_player_join
execute as @a run scoreboard players set @s macro.hook_online 1

# player_death — deaths score artışını tespit et
execute as @a[scores={macro.hook_deaths=1..}] run function macro:hook/internal/on_player_death
execute as @a[scores={macro.hook_deaths=1..}] run scoreboard players set @s macro.hook_deaths 0

# player_respawn — öldü (dead flag var) ama artık sağ
execute as @a[tag=macro.hook_dead,nbt={DeathTime:0s}] run function macro:hook/internal/on_player_respawn
execute as @a[tag=macro.hook_dead,nbt={DeathTime:0s}] run tag @s remove macro.hook_dead
execute as @a[nbt={DeathTime:1s}] run tag @s add macro.hook_dead

# level_up — XP level artışı
execute as @a run function macro:hook/internal/check_level_up

# block_place — placed_blocks score artışı
execute as @a[scores={macro.hook_placed=1..}] run function macro:hook/internal/on_block_place
execute as @a[scores={macro.hook_placed=1..}] run scoreboard players set @s macro.hook_placed 0
