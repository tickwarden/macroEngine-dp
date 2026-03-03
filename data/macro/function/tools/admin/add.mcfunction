execute unless entity @s[tag=macro.admin] run return 0

# Admin yetkisini ver
$tag $(NAME) add macro.admin
tellraw @s {"text":"Admin yetkisi verildi:","color":"green"}
$tellraw @s {"text":"$(NAME)","color":"gray"}
$tellraw @a {"text":"$(NAME) artık admin!","color":"aqua"}
