# macro:cmd/title_sub — Başlık + alt başlık birlikte gönder
# INPUT: macro:input { player:"<ad>", title:"<metin>", subtitle:"<metin>",
#                      color:"<renk>", sub_color:"<renk>" }

$title @a[name=$(player),limit=1] title {"text":"$(title)","color":"$(color)","bold":true}
$title @a[name=$(player),limit=1] subtitle {"text":"$(subtitle)","color":"$(sub_color)","italic":true}
