# macro:cmd/spreadplayers — Oyuncuları alana yay
# INPUT: macro:input { cx:<float>, cz:<float>, spread:<float>, max_range:<float>, target:"<selector>" }
# ÖRNEK: cx:0, cz:0, spread:5, max_range:50, target:"@a"
# spread: min oyuncu arası mesafe, max_range: merkeze max uzaklık

$spreadplayers $(cx) $(cz) $(spread) $(max_range) false $(target)
