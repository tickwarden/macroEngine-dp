# ============================================
# macro:team/count
# ============================================
# Takımdaki online oyuncu sayısını döndürür.
# INPUT:  macro:input { team:"<isim>" }
# OUTPUT: macro:output { result:<int> }
# ============================================

scoreboard players set $team_cnt macro.tmp 0
$execute as @a[team=$(team)] run scoreboard players add $team_cnt macro.tmp 1
execute store result storage macro:output result int 1 run scoreboard players get $team_cnt macro.tmp
