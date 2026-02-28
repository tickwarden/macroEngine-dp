# macro:string/copy_to_clipboard
# INPUT: macro:input { target, text, color, copy_value }

$tellraw $(target) {"text":"$(text)","color":"$(color)","clickEvent":{"action":"copy_to_clipboard","value":"$(copy_value)"},"click_event":{"action":"copy_to_clipboard","value":"$(copy_value)"},"hover_event":{"action":"show_text","value":{"text":"Panoya kopyala","color":"gray","italic":true}}}