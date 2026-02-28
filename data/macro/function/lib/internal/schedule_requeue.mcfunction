# schedules.$(key) compound'undan {func, interval} alır ve kuyruğa ekler
$data modify storage macro:engine queue append value {func:"$(func)", delay:$(interval)}
