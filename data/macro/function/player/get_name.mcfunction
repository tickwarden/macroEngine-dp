# ============================================
# macro:player/get_name
# ============================================
# @s'nin gerçek adını ve UUID'sini player head
# aracılığıyla okuyup storage'a yazar.
#
# ⚠ ÖN KOŞUL: 0 300 0 koordinatındaki chunk forceload
# edilmiş olmalıdır. Bu işlem macro:load tarafından
# otomatik yapılır; ayrıca el ile yapmana gerek YOK.
#
# ÇALIŞMA ŞEMASI:
# 1) 0 300 0'a black_shulker_box yerleştir
# 2) macro:player/head loot table ile @s'nin kafasını slot 0'a yaz
# 3) profile.name → macro:names temp.NAME
# 4) @s UUID[0..3] → macro:names temp.UUID[]
# 5) Bloğu hava ile temizle
#
# ÇIKIŞ (storage macro:names temp):
# NAME : string — oyuncu adı (büyük-küçük harf korunur)
# UUID : int[] — [0,1,2,3] dizi; 4 × int
#
# BAĞIMLILIK:
# loot table macro:player/head (fill_player_head this)
#
# ÖRNEK:
# execute as <oyuncu> run function macro:player/get_name
# data get storage macro:names temp.NAME
# ============================================

# ─── Temizlik: önceki geçici veriyi sil ──────────────────
data remove storage macro:names temp

# ─── Shulker box koy (forceload zaten aktif) ─────────────
setblock 0 300 0 black_shulker_box replace

# ─── @s kafasını slota yaz ───────────────────────────────
loot insert 0 300 0 loot macro:player/head

# ─── Ad oku ──────────────────────────────────────────────
data modify storage macro:names temp.NAME set from block 0 300 0 Items[0].components."minecraft:profile".name

# ─── UUID oku (Minecraft UUID = 4 adet int) ──────────────
data modify storage macro:names temp.UUID insert 0 from entity @s UUID[0]
data modify storage macro:names temp.UUID insert 1 from entity @s UUID[1]
data modify storage macro:names temp.UUID insert 2 from entity @s UUID[2]
data modify storage macro:names temp.UUID insert 3 from entity @s UUID[3]

# ─── Temizlik: bloğu kaldır ──────────────────────────────
setblock 0 300 0 air replace