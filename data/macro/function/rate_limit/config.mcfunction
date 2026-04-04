# macro:rate_limit/config — load sırasında çağrılır
# Saniyede maksimum aksiyon sayısı
scoreboard players set #rl_limit macro.rl_count 10
# Limit aşılınca uygulanacak cooldown (tick)
scoreboard players set #rl_cd macro.rl_cd 60
# Global saniye sayacı sıfırla
scoreboard players set #rl_timer macro.rl_cd 0
