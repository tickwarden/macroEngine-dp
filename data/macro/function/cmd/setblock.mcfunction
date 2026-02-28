# macro:cmd/setblock — Belirtilen konuma blok yerleştir
# INPUT: macro:input { x:<int>, y:<int>, z:<int>, block:"<block_id>", mode:"replace"|"keep"|"destroy" }
# mode opsiyoneldir, varsayılan: replace

$setblock $(x) $(y) $(z) $(block) $(mode)
