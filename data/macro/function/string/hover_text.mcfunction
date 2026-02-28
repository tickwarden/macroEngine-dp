# macro:string/hover_text
# INPUT: macro:input { target, text, color, hover, hover_color }
$tellraw $(target) {"text":"$(text)","color":"$(color)","hover_event":{"action":"show_text","value":{"text":"$(hover)","color":"$(hover_color)"}}}
