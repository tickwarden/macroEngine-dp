# Queue'nun ilk elemanını çalıştır ve sil
# queue_run_head + queue_execute_first + queue_tick_all'ın yerini alır
function macro:lib/internal/queue_run_func with storage macro:engine queue[0]
data remove storage macro:engine queue[0]
