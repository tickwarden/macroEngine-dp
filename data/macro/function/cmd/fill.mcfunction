# macro:cmd/fill — Bir bölgeyi blokla doldur
# INPUT: macro:input { x1:<int>, y1:<int>, z1:<int>, x2:<int>, y2:<int>, z2:<int>,
#                      block:"<block_id>", mode:"replace"|"keep"|"destroy"|"hollow"|"outline" }

$fill $(x1) $(y1) $(z1) $(x2) $(y2) $(z2) $(block) $(mode)
