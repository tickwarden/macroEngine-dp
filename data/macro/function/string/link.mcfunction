# macro:string/link
# INPUT: macro:input { target, text, color, url }
$tellraw $(target) {text:"$(text)",color:"$(color)",underlined:1b,click_event:{action:"open_url",url:"$(url)"},hover_event:{action:"show_text",value:{text:"$(url)",color:"gray"}}}
