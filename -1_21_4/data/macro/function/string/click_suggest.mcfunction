# macro:string/click_suggest — eski sözdizimi (1.21.4 ve öncesi)
# INPUT: macro:input { target, text, color, suggest }
$tellraw $(target) {"text":"$(text)","color":"$(color)","clickEvent":{"action":"suggest_command","value":"$(suggest)"},"hoverEvent":{"action":"show_text","value":{"text":"Tıkla","color":"gray","italic":true}}}
