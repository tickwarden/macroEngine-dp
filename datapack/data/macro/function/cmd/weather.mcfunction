# macro:cmd/weather — Hava durumunu ayarla
# INPUT: macro:input { type:"clear"|"rain"|"thunder", duration:<int> }
# duration: saniye cinsinden (0 = varsayılan)

$weather $(type) $(duration)
