# macro:cmd/xp_add — Oyuncuya XP ekle
# INPUT: macro:input { player:"<ad>", amount:<int>, type:"points"|"levels" }
# type "points" → ham XP puanı, "levels" → seviye ekler

$execute as @a[name=$(player),limit=1] run xp add @s $(amount) $(type)
