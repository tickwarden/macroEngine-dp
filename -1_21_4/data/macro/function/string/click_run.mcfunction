# macro:string/click_run — eski sözdizimi (1.21.4 ve öncesi)
# INPUT: macro:input { target, text, color, command }
$tellraw $(target) {"text":"$(text)","color":"$(color)","clickEvent":{"action":"run_command","value":"$(command)"},"hoverEvent":{"action":"show_text","value":{"text":"Tıkla","color":"gray","italic":true}}}
