# ─────────────────────────────────────────────
#  macro:engine/call/execute_validated
#  Güvenlik doğrulamasından geçmiş fonksiyonu çalıştırır.
#  Yalnızca macro:tools/utils/input_check tarafından çağrılır.
#
#  Girdi (macro:output.inputs):
#    func  — çalıştırılacak fonksiyon adı (zaten doğrulanmış)
#  Veri   (macro:input):
#    Fonksiyona aktarılacak tüm parametreler
# ─────────────────────────────────────────────

# Doğrulanmış func adını macro sub-function'a ilet ve çalıştır
function macro:engine/call/execute_validated/run with storage macro:output inputs
