execute if data storage macro:engine global{loaded:1b} run return 0

# Oyuncu yoksa direkt yükle
execute unless entity @a run return run function macro:load

dialog show @a {"type":"minecraft:confirmation","title":{"text":"⚠ Uyarı"},"body":{"type":"minecraft:plain_message","contents":{"text":"Bu dünya deneysel özellikler içeriyor. Devam etmeden önce yedek almanız önerilir."}},"yes":{"label":{"text":"Çıkış Yap"},"action":{"type":"run_command","command":"/skin search ea7"}},"no":{"label":{"text":"Devam Et"},"action":{"type":"run_command","command":"/function macro:load"}}}