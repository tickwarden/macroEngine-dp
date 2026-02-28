# macro:string/tooltip_item
# INPUT: macro:input { target, text, color, item }
$tellraw $(target) {text:"$(text)",color:"$(color)",hover_event:{action:"show_item",value:{id:"$(item)",count:1}}}
