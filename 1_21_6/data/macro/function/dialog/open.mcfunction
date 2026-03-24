scoreboard players set @s macro.dialog_load -1
tag @s remove macro.dialog_closed

tag @s remove macro.dialog_opened


execute unless data storage macro:engine dialog.DIALOG run return run dialog show @s {"type":"multi_action","title":"","actions":[{label:"Ok"}],"pause":false,"after_action":"close",body:{"type":"plain_message","contents":[{"text":"A problem occurred.","bold":true,"color":"yellow","italic":false},"\n\n",{"text":"Dialog Not Found","color":"red","bold":false,"italic":false}]}}
execute if data storage macro:engine {dialog:{DIALOG:""}} run return run dialog show @s {"type":"multi_action","title":"","actions":[{label:"Ok"}],"pause":false,"after_action":"close",body:{"type":"plain_message","contents":[{"text":"A problem occurred.","bold":true,"color":"yellow","italic":false},"\n\n",{"text":"Unknown Dialog","color":"red","bold":false,"italic":false}]}}
execute unless data storage macro:engine dialog.DIALOG.type run return run dialog show @s {"type":"multi_action","title":"","actions":[{label:"Ok"}],"pause":false,"after_action":"close",body:{"type":"plain_message","contents":[{"text":"A problem occurred.","bold":true,"color":"yellow","italic":false},"\n\n",{"text":"Unknown Dialog Type","color":"red","bold":false,"italic":false}]}}

execute if data storage macro:engine dialog.DIALOG run return run function macro:dialog/show

return 1
