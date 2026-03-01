# ============================================
# macro:flag/toggle
# ============================================
# Global bayrak tersine cevir.
# Set ise unset olur; unset ise set olur.
#
# INPUT:  macro:input { key:"<bayrak_adi>" }
# OUTPUT: macro:output { result: 1b (yeni durum set) / 0b (yeni durum unset) }
#
# ORNEK:
#   data modify storage macro:input key set value "pvp_enabled"
#   function macro:flag/toggle with storage macro:input {}
# ============================================

# Mevcut durumu skora yukle: var=1, yok=0
scoreboard players set $ftgl macro.tmp 0
$execute if data storage macro:engine flags.$(key) run scoreboard players set $ftgl macro.tmp 1

# Var ise kaldir, output 0b
$execute if score $ftgl macro.tmp matches 1 run data remove storage macro:engine flags.$(key)
execute if score $ftgl macro.tmp matches 1 run data modify storage macro:output result set value 0b

# Yok ise koy, output 1b
$execute if score $ftgl macro.tmp matches 0 run data modify storage macro:engine flags.$(key) set value 1b
execute if score $ftgl macro.tmp matches 0 run data modify storage macro:output result set value 1b
