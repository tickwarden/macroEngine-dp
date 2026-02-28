# macro:string/click_run
# INPUT: macro:input { target, text, color, command }
$tellraw $(target) {text:"$(text)",color:"$(color)",click_event:{action:"run_command",command:"$(command)"},hover_event:{action:"show_text",value:{text:"Tıkla",color:"gray",italic:1b}}}
