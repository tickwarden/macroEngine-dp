# ============================================
# macro:cmd/advancement_grant
# ============================================
# Oyuncuya advancement verir.
# macro:advancement/ altındaki JSON'ları kullanır.
#
# INPUT: macro:input { player:"<ad>", advancement:"<namespace:id>" }
#
# MEVCUT ADVANCEMENT'LAR (şablon — kopyalayıp düzenle):
#   macro:template/task        — Normal görev çerçevesi
#   macro:template/goal        — Yıldız çerçeve, sohbet duyurusu
#   macro:template/challenge   — Altın çerçeve, +100 XP ödülü
#
# ÖRNEK:
#   data modify storage macro:input player set value "Steve"
#   data modify storage macro:input advancement set value "macro:template/goal"
#   function macro:cmd/advancement_grant with storage macro:input {}
# ============================================

$advancement grant @a[name=$(player),limit=1] only $(advancement)
