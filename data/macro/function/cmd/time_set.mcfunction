# macro:cmd/time_set — Oyun saatini ayarla
# INPUT: macro:input { value:<int>|"day"|"noon"|"night"|"midnight"|"sunrise"|"sunset" }
# Tamsayı: tick cinsinden (0=gündoğumu, 6000=öğle, 12000=gün batımı, 18000=gece yarısı)

$time set $(value)
