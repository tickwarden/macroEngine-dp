# ============================================
# macro:config/get
# ============================================
# Config'den değer okur.
# INPUT:  macro:input { key:"<anahtar>" }
# OUTPUT: macro:output { result: <değer> | "" (yoksa) }
# ============================================

# Varsayılan boş string (key bulunamazsa)
data modify storage macro:output result set value ""

$execute if data storage macro:engine config.$(key) run data modify storage macro:output result set from storage macro:engine config.$(key)
