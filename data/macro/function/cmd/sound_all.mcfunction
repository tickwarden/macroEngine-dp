# macro:cmd/sound_all — Tüm oyunculara ses çal
# INPUT: macro:input { sound:"<sound_id>", volume:<float>, pitch:<float> }

$playsound $(sound) master @a ~ ~ ~ $(volume) $(pitch)
