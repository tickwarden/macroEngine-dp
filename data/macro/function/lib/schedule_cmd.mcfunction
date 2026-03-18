# ─────────────────────────────────────────────
#  macro:lib/schedule_cmd
#  Belirli bir süre aralığında tekrar eden komut zamanlayıcısı.
#
#  Girdi (macro:input):
#    key      — zamanlayıcı adı (benzersiz tanımlayıcı)
#    cmd      — her tetiklendiğinde çalıştırılacak ham komut
#    interval — tick cinsinden tekrar aralığı
# ─────────────────────────────────────────────

$execute if data storage macro:engine schedules.$(key) run data remove storage macro:engine schedules.$(key)

$data modify storage macro:engine schedules.$(key).cmd set value "$(cmd)"
$data modify storage macro:engine schedules.$(key).interval set value $(interval)
$data modify storage macro:engine queue append value {cmd:"$(cmd)", delay:$(interval)}
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"lib/schedule_cmd ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(key)","color":"aqua"},{"text":" ($(interval)t)","color":"#555555"}]
