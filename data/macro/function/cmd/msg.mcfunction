# ============================================
# macro:cmd/msg
# ============================================
# Belirtilen oyuncuya özel (whisper) mesaj gönderir.
# Yalnızca hedef oyuncu görebilir.
#
# INPUT: macro:input { player:"<hedef>", message:"<mesaj>" }
#
# ÖRNEK:
#   data modify storage macro:input player set value "Steve"
#   data modify storage macro:input message set value "Gizli bilgi!"
#   function macro:cmd/msg with storage macro:input {}
# ============================================

$tellraw $(player) {"text":"$(message)","color":"gray","italic":true}
