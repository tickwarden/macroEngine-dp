# Doğrudan çağırmayın — schedule_reset tarafından kullanılır.
# Makro INPUT: { func:"<f>", interval:<n>, key:"<k>" }
$data modify storage macro:engine schedules.$(key).func set value "$(func)"
$data modify storage macro:engine schedules.$(key).interval set value $(interval)
$data modify storage macro:engine queue append value {func:"$(func)", delay:$(interval)}
