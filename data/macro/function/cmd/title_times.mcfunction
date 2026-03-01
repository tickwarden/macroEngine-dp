# macro:cmd/title_times — Title animasyon sürelerini ayarla
# INPUT: macro:input { player:"<ad>", fade_in:<tick>, stay:<tick>, fade_out:<tick> }

$execute as @a[name=$(player),limit=1] at @s run title @s times $(fade_in) $(stay) $(fade_out)
