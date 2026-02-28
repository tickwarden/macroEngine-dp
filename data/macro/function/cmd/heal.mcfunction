# macro:cmd/heal — Oyuncuyu iyileştir (instant_health efekti)
# INPUT: macro:input { player:"<ad>", amount:<int> }
# amount: 0=I, 1=II, 2=III (amplifier, her seviye 2 kalp)

$execute as @a[name=$(player),limit=1] at @s run effect give @s minecraft:instant_health 1 $(amount) true
