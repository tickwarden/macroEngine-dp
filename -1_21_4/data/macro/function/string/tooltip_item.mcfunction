# macro:string/tooltip_item — eski sözdizimi (1.21.4 ve öncesi)
# INPUT: macro:input { target, text, color, item }
$tellraw $(target) {"text":"$(text)","color":"$(color)","hoverEvent":{"action":"show_item","value":{"id":"$(item)","count":1}}}
