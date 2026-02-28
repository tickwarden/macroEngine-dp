# macro:string/copy_to_clipboard — eski sözdizimi (1.21.4 ve öncesi)
# INPUT: macro:input { target, text, color, copy_value }
$tellraw $(target) {"text":"$(text)","color":"$(color)","clickEvent":{"action":"copy_to_clipboard","value":"$(copy_value)"},"hoverEvent":{"action":"show_text","value":{"text":"Panoya kopyala","color":"gray","italic":true}}}
