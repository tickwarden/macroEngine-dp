# macro:hook/internal/fire [MACRO]
# INPUT: $(event) — tetiklenecek event adı
# @s = tetikleyen oyuncu
# hook_binds listesini kopyalayıp dispatch eder.

$data modify storage macro:engine _hook_fire_event set value "$(event)"
data modify storage macro:engine _hook_iter set from storage macro:engine hook_binds
function macro:hook/internal/dispatch

data remove storage macro:engine _hook_iter
data remove storage macro:engine _hook_fire_event
