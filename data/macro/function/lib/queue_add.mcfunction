# ============================================
# macro:lib/queue_add
# ============================================
# Makroyu belirli tick sonra çalıştırmak için kuyruğa ekle.
# BUG FIX: context artık macro:input.context'ten okunuyor.
#
# INPUT: macro:input { func:"<namespace:path>", delay:<int> }
# ÖRNEK:
#   data modify storage macro:input func set value "mypack:event/end"
#   data modify storage macro:input delay set value 100
#   function macro:lib/queue_add with storage macro:input {}
# ============================================

$data modify storage macro:engine queue append value {func:"$(func)", delay:$(delay)}
