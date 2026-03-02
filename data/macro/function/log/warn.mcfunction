# ============================================
# macro:log/warn
# ============================================
# WARN seviyesinde log ekler (sarı).
#
# INPUT: macro:input { message:"<metin>" }
# ÇAĞIRIM:
# data modify storage macro:input message set value "Cooldown süresi dolmadı"
# function macro:log/warn with storage macro:input {}
# ============================================

$data modify storage macro:input message set value "$(message)"
data modify storage macro:input level set value "WARN"
data modify storage macro:input color set value "yellow"
function macro:log/add with storage macro:input {}
