# macro:string/announce_prefix
# INPUT: macro:input { prefix, prefix_color, message, color }
$tellraw @a [{"text":"$(prefix) ","color":"$(prefix_color)","bold":true},{"text":"$(message)","color":"$(color)","bold":false}]
