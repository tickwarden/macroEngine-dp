# ============================================
# macro:log/error
# ============================================
# ERROR seviyesinde log ekler (kırmızı).
#
# INPUT: macro:input { message:"<metin>" }
# ÇAĞIRIM:
# data modify storage macro:input message set value "Storage okunamadı"
# function macro:log/error with storage macro:input {}
# ============================================

$data modify storage macro:input message set value "$(message)"
data modify storage macro:input level set value "ERROR"
data modify storage macro:input color set value "red"
function macro:log/add with storage macro:input {}
