# ============================================
# macro:log/debug
# ============================================
# DEBUG seviyesinde log ekler (gri).
# Yalnızca macro.debug tag'i olan oyuncuların görmesi için
# tasarlanmıştır; log/show yine de hepsini gösterir.
#
# INPUT: macro:input { message:"<metin>" }
# ÇAĞIRIM:
# data modify storage macro:input message set value "tick: 12345"
# function macro:log/debug with storage macro:input {}
# ============================================

$data modify storage macro:input message set value "$(message)"
data modify storage macro:input level set value "DEBUG"
data modify storage macro:input color set value "gray"
function macro:log/add with storage macro:input {}
