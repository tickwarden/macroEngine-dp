# ============================================
# macro:event/fire_queued
# ============================================
# Event'i anlik degil, belirtilen delay tick sonra fire eder.
# Mevcut tick'in yukunu dagitmak veya gecikmeli tetikleme icin kullanilir.
#
# BUG FIX v3.2: _fdeferred yerine event adi dogrudan queue item'a
# gömülür. Boylece ayni tick'te birden fazla fire_queued cagrisi
# birbirinin event adini ezmez.
#
# INPUT: macro:input { event:"<event_adi>", delay:<tick> }
#
# ORNEK:
#   data modify storage macro:input event set value "on_round_end"
#   data modify storage macro:input delay set value 60
#   function macro:event/fire_queued with storage macro:input {}
#   # 3 saniye sonra on_round_end tetiklenecek
# ============================================

# Event kayitli degilse kuyruga ekleme
$execute unless data storage macro:engine events.$(event) run return 0

# event adini queue item'in icine göm — _fdeferred race condition yok
$data modify storage macro:engine queue append value {func:"macro:event/internal/fire_deferred", delay:$(delay), event:"$(event)"}
