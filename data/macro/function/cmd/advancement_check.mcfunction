# ============================================
# macro:cmd/advancement_check
# ============================================
# Oyuncunun advancement'a sahip olup olmadığını kontrol eder.
# OUTPUT: macro:output { result: 1b/0b }
#
# INPUT: macro:input { player:"<ad>", advancement:"<namespace:id>" }
#
# ÖRNEK:
#   data modify storage macro:input player set value "Steve"
#   data modify storage macro:input advancement set value "macro:template/goal"
#   function macro:cmd/advancement_check with storage macro:input {}
#   # → macro:output { result: 1b }  (varsa)
# ============================================

data modify storage macro:output result set value 0b
$execute if entity @a[name=$(player),limit=1,advancements={$(advancement)=true}] run data modify storage macro:output result set value 1b
