# ============================================
# macro:flag/get
# ============================================
# Global bayrağın durumunu kontrol eder.
#
# INPUT:  macro:input { key:"<bayrak_adı>" }
# OUTPUT: macro:output { result: 1b (set) / 0b (unset) }
#
# ÖRNEK:
#   data modify storage macro:input key set value "game_started"
#   function macro:flag/get with storage macro:input {}
#   # macro:output.result → 1b veya 0b
# ============================================

data modify storage macro:output result set value 0b
$execute if data storage macro:engine flags.$(key) run data modify storage macro:output result set value 1b
