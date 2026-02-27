# ============================================
# macro:string/announce
# ============================================
# Tüm oyunculara renkli sistem duyurusu gönderir.
# INPUT: macro:input { message:"<metin>", color:"<renk>" }
# ÖRNEK:
#   data modify storage macro:input message set value "Etkinlik başladı!"
#   data modify storage macro:input color set value "gold"
#   function macro:string/announce with storage macro:input {}
# ============================================

$tellraw @a {"text":"$(message)","color":"$(color)"}
