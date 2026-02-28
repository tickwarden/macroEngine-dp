# macro:cmd/bossbar_set_value — Bossbar değerini ayarla (0..max)
# INPUT: macro:input { id:"<namespace:id>", value:<int> }

$bossbar set $(id) value $(value)
