# ============================================
# macro:player/reset
# ============================================
# Oyuncunun tüm verilerini siler ve varsayılanlara döndürür.
# ⚠️ GERİ ALINAMAZ — DİKKATLİ KULLAN!
# INPUT: macro:input { player:"<ad>" }
# ============================================

# Tüm veriyi sil
$data remove storage macro:engine players.$(player)
# Cooldown'ları da temizle
$data remove storage macro:engine cooldowns.$(player)

# Varsayılanları yeniden uygula
function macro:player/init with storage macro:input {}
