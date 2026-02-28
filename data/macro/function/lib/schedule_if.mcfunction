# macro:lib/schedule_if — Yalnızca func alanı doluysa kuyruğa ekle
# Bireysel queue_add çağrısı ile eşdeğer, fark yok — queue_add'ı kullan.
# Bu dosya gereksiz — queue_add tercih edilmeli.
# (Bu dosya geriye dönük uyumluluk için tutulmuştur)
function macro:lib/queue_add with storage macro:input {}
