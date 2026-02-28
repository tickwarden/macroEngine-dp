execute if data storage macro:engine global{loaded:1b} run return 0

# Oyuncu yoksa direkt yükle
execute unless entity @a run return run function macro:load

# BUG FIX v3.5:
#   1. CRLF satır sonları → LF
#   2. "yes"/"no" butonlar ters + /skin search ea7 test kalıntısı kaldırıldı
#   3. BUG FIX v3.6: /kick ve /disconnect dialog run_command'dan çalışmaz.
#      Confirmation tipi yerine notice tipi kullanıldı — tek "Yükle" butonu yeterli.
dialog show @a {"type":"minecraft:notice","title":{"text":"⚠ Uyarı","color":"yellow","bold":true},"body":{"type":"minecraft:plain_message","contents":{"text":"Bu dünya deneysel özellikler içeriyor.\nDevam etmeden önce yedek almanız önerilir."}},"action":{"label":{"text":"Anladım, Yükle","color":"green","bold":true},"action":{"type":"run_command","command":"/function macro:load"}}}
