# macro:cmd/kick — Oyuncuyu sunucudan at
# INPUT: macro:input { player:"<ad>", reason:"<sebep>" }

$kick @a[name=$(player),limit=1] $(reason)
