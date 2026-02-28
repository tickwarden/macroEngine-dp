execute if data storage macro:engine global{loaded:1b} run return 0

execute unless entity @a run return run function macro:load

tellraw @a {"text":"⚠ Uyarı: Bu dünya deneysel özellikler içeriyor. /function macro:load komutuyla yükleyebilirsiniz.","color":"yellow"}
