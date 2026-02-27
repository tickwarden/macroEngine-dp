# ============================================
# macro:config/reset
# ============================================
# TÜM config değerlerini siler. ⚠️ Geri alınamaz!
# INPUT:  —
# OUTPUT: —
# ============================================

data remove storage macro:engine config
tellraw @a[tag=macro.debug] {"text":"[Config] ⚠️ Tüm config silindi!","color":"red"}
