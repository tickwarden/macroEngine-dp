# macro:string/announce
# INPUT: macro:input { message, color }
$tellraw @a {text:"$(message)",color:"$(color)"}
