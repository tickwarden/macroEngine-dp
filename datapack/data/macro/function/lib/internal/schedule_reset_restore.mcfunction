# Doğrudan çağırmayın — schedule_reset tarafından kullanılır.
# Makro: { func:"<f>", interval:<n> }
$data modify storage macro:engine schedules.$(key).func set value "$(func)"
$data modify storage macro:engine schedules.$(key).interval set value $(interval)
