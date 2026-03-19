# macro:hook/internal/check_bind [MACRO]
# INPUT: $(event) — _hook_ctx'deki bind'ın event field'ı
# _hook_fire_event ile eşleşiyorsa func veya cmd'yi çalıştır.
# @s = tetikleyen oyuncu

$execute if data storage macro:engine {_hook_fire_event:"$(event)"} run function macro:hook/internal/exec with storage macro:engine _hook_ctx
