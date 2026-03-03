execute unless entity @s[tag=macro.admin] run return 0

# Admin yetkisini al
$tag $(NAME) remove macro.admin
tellraw @s {"text":"Admin yetkisi aldındı:","color":"red"}
$tellraw @s [{"text":"$(NAME)","color":"aqua"}]
