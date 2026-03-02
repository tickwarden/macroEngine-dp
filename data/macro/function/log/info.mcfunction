# ============================================
# macro:log/info
# ============================================
# INFO seviyesinde log ekler (yeşil).
#
# INPUT: macro:input { message:"<metin>" }
# ÇAĞIRIM:
# data modify storage macro:input message set value "Sunucu başlatıldı"
# function macro:log/info with storage macro:input {}
# ============================================

$data modify storage macro:input message set value "$(message)"
data modify storage macro:input level set value "INFO"
data modify storage macro:input color set value "green"
function macro:log/add with storage macro:input {}
