# macro:string/click_suggest
# INPUT: macro:input { target, text, color, suggest }
$tellraw $(target) {"text":"$(text)","color":"$(color)","clickEvent":{"action":"suggest_command","value":"$(suggest)"},"click_event":{"action":"suggest_command","command":"$(suggest)"},"hover_event":{"action":"show_text","value":{"text":"Tıkla","color":"gray","italic":true}}}
