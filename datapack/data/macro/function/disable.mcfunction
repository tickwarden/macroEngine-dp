playsound minecraft:block.note_block.pling master @s ~ ~ ~ 4 2

function macro:disable/main

tellraw @s [{"text":"Tekrar baslatmak icin:"}," ",{"text":"Tikla!","click_event":{"action":"run_command","command":"/function macro:load"},"clickEvent":{"action":"run_command","value":"/function macro:load"},"color":"aqua","bold":true,"italic":false}]