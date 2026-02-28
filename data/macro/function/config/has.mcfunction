# ============================================
# macro:config/has
# ============================================
# Belirtilen config key'i var mı kontrol eder.
# INPUT:  macro:input { key:"<anahtar>" }
# OUTPUT: macro:output { result: 1b (var) | 0b (yok) }
# ============================================

data modify storage macro:output result set value 0b
$execute if data storage macro:engine config.$(key) run data modify storage macro:output result set value 1b
