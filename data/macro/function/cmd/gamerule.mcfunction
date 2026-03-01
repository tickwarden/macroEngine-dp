# macro:cmd/gamerule — Oyun kuralını değiştir
# INPUT: macro:input { rule:"<kural_adı>", value:"<değer>" }
# ÖRNEK: rule:"keepInventory", value:"true"
# ÖRNEK: rule:"randomTickSpeed", value:"3"

$gamerule $(rule) $(value)
