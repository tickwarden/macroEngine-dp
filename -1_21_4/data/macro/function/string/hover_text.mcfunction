# macro:string/hover_text — eski sözdizimi (1.21.4 ve öncesi)
# INPUT: macro:input { target, text, color, hover, hover_color }
$tellraw $(target) {"text":"$(text)","color":"$(color)","hoverEvent":{"action":"show_text","value":{"text":"$(hover)","color":"$(hover_color)"}}}
