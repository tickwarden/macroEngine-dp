# ============================================
# Progress Bar Başlatma Örneği
# ============================================
# Bu fonksiyonu çalıştırarak progress bar'ı aktif edebilirsiniz
# Komut: /function macro:start_progressbar
#
# Can göstergesi için:
# /function macro:start_progressbar
#
# Kapatmak için:
# /function macro:stop_progressbar
# ============================================

# Can (health) progress bar'ını başlat
$data modify storage macro:engine pb_obj set value "$(pb_obj)"
$data modify storage macro:engine pb_max set value $(max)
$data modify storage macro:engine pb_label set value "$(label)"
