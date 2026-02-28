# ============================================
# macro:debug/example_events
# ============================================
# Event sistemini gösteren örnek debug fonksiyonu.
# /function macro:debug/example_events ile çalıştırın.
# ============================================

tellraw @a[tag=macro.debug] {"text":"[DEBUG] event sistemi test basliyor...","color":"yellow"}

# ─── on_join event kaydı ─────────────────────────────────
data modify storage macro:input event set value "on_join"
data modify storage macro:input func set value "macro:debug/internal/on_join_handler"
function macro:event/register with storage macro:input {}

# ─── on_kill event kaydı ─────────────────────────────────
data modify storage macro:input event set value "on_kill"
data modify storage macro:input func set value "macro:debug/internal/on_kill_handler"
function macro:event/register with storage macro:input {}

# ─── Context'i ayarla ve on_join event'ini tetikle ───────
# BUG FIX: "event_context set value {}" geçersiz — kök path kabul edilmez.
# BUG FIX: "event_context$(player)" → "event_context.player" (nokta eksikti)
data remove storage macro:engine event_context
data modify storage macro:engine event_context.player set value "TestOyuncu"
data modify storage macro:engine event_context.reason set value "debug_test"

# ─── Event'i ateşle ──────────────────────────────────────
data modify storage macro:input event set value "on_join"
function macro:event/fire with storage macro:input {}
# BUG FIX: "data modify storage macro:input set value {}" geçersiz — tek tek temizle
data remove storage macro:input event

tellraw @a[tag=macro.debug] {"text":"[DEBUG] example_events tamamlandi.","color":"green"}
