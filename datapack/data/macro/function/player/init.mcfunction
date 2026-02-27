# ============================================
# macro:player/init
# ============================================
# Oyuncu sunucuya ilk girdiğinde veya reset'te çağrılır.
# INPUT: macro:input { player:"<oyuncuAdı>" }
# ============================================

# Üst level storage oluştur (yoksa)
$execute unless data storage macro:engine players.$(player) run data modify storage macro:engine players.$(player) set value {}

# Coin: sadece yoksa 0 ata (0 değeri de korunur)
$execute unless data storage macro:engine players.$(player).coins run data modify storage macro:engine players.$(player).coins set value 0

# Level: sadece yoksa 1 ata
$execute unless data storage macro:engine players.$(player).level run data modify storage macro:engine players.$(player).level set value 1

# XP: sadece yoksa 0 ata
$execute unless data storage macro:engine players.$(player).xp run data modify storage macro:engine players.$(player).xp set value 0

# Online bayrağı
$data modify storage macro:engine players.$(player).online set value 1b

# BUG FIX v2.4+: $tick (0-20 döngüsel) yerine $epoch (mutlak) kullanılıyor
# İlk giriş epoch'unu kaydet (sadece yoksa)
$execute unless data storage macro:engine players.$(player).first_join_tick run execute store result storage macro:engine players.$(player).first_join_tick int 1 run scoreboard players get $epoch macro.time

# Her girişte son giriş epoch'unu güncelle
$execute store result storage macro:engine players.$(player).last_join_tick int 1 run scoreboard players get $epoch macro.time
