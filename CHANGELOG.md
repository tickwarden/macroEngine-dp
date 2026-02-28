# Advanced Macro Engine — Changelog

## v3.2 (Geliştirme)

### 🐛 Bug Fixes
- **math/random**: `$epoch=0` durumunda (ilk tick veya sunucu yeni başladığında) LCG tohumunun çok zayıf kalması giderildi. 57005 (0xDEAD) sabit ofseti eklendi; `$tick*31` ile aynı tick'teki çağrılar daha iyi entropi ile ayrıştırılıyor.

### ✨ Yeni: Event Sistemi
| Fonksiyon | Açıklama |
|---|---|
| `event/unregister_one` | Bir event'ten yalnızca belirli bir handler'ı siler (diğerleri korunur) |
| `event/has` | Event'in kayıtlı handler'ı var mı kontrol eder → `1b/0b` |
| `event/count` | Kayıtlı handler sayısını döndürür |
| `event/clear_context` | `event_context` storage'ını temizler |
| `event/fire_queued` | Event'i N tick sonra asenkron olarak fire eder |

### ✨ Yeni: Queue / Zamanlama
| Fonksiyon | Açıklama |
|---|---|
| `lib/queue_clear` | Bekleyen tüm kuyruk öğelerini siler |
| `lib/schedule_list` | Aktif schedule'ları ve queue'yu debug olarak gösterir |
| `lib/schedule_reset` | Bir schedule'ın geri sayımını sıfırlar (cancel + reschedule) |

### ✨ Yeni: Matematik Kütüphanesi
| Fonksiyon | Açıklama |
|---|---|
| `math/map` | Bir değeri `[in_min, in_max]` → `[out_min, out_max]` aralığına eşler |
| `math/wrap` | Değeri `[min, max)` döngüsel aralıkta tutar (rotasyon, indeks sarma) |
| `math/log2` | `floor(log₂(value))` — 2 tabanında tamsayı logaritma |
| `math/mod` | Güvenli modulo — her zaman `[0, divisor)` sonuç verir (negatif koruma) |

### ✨ Yeni Modül: `flag/`
Global boolean bayrak sistemi. Oyun durumları, özellik anahtarları ve koşullu mantık için.
- `flag/set` — bayrak koy
- `flag/unset` — bayrağı kaldır
- `flag/get` → `1b/0b`
- `flag/toggle` → tersle, yeni durumu döndür
- `flag/list` — tüm bayrakları debug'da göster

### ✨ Yeni Modül: `state/`
Oyuncu durum makinesi. Her oyuncuya string bir durum atanabilir.
- `state/set` — durum ata
- `state/get` → durum string'i
- `state/is` → `1b/0b` eşleşme kontrolü
- `state/clear` — oyuncunun durumunu sil
- `state/clear_all` — tüm oyuncu durumlarını sil
- `state/list` — debug'da göster

### ✨ Yeni: cmd/ Komutları
| Fonksiyon | Açıklama |
|---|---|
| `cmd/msg` | Oyuncuya özel (whisper) metin mesajı |
| `cmd/msg_raw` | Oyuncuya ham JSON tellraw mesajı |
| `cmd/clone` | Blok bölgesi kopyalama |
| `cmd/clone_masked` | Yalnızca hava olmayan blokları kopyala |
| `cmd/ride` | Oyuncuyu/entity'yi araça bindir |
| `cmd/ride_dismount` | Araçtan indir |
| `cmd/forceload_add` | Chunk'ı zorla yüklü tut |
| `cmd/forceload_remove` | Zorla yüklemeyi kaldır |
| `cmd/trigger_set` | Trigger objective değerini ayarla |
| `cmd/spectate` | Spectator oyuncuyu hedefe bağla |
| `cmd/spectate_stop` | Spectator izlemeyi sonlandır |
| `cmd/place_feature` | Feature yerleştir (ağaç, mineral vb.) |
| `cmd/place_structure` | NBT yapısı yerleştir |

---

## v3.1

### 🐛 Bug Fixes
- **lib/schedule**: Aynı key ile tekrar çağrılınca queue'ya duplicate giriş eklenmesi giderildi. Artık yalnızca `func/interval` güncellenir.

---

## v3.0

### 🐛 Bug Fixes
- **load**: `$epoch macro.time` artık `/reload`'da sıfırlanmıyor — cooldown'lar sunucu yeniden başlatmadan korunuyor.
- **lib/process_queue**: `$pq_depth` ile tick başına 256 özyineleme limiti eklendi — stack overflow engeli.
- **debug/example_events**: `event_context` path düzeltildi, input temizleme düzeltildi.

---

## v2.5

### 🐛 Bug Fixes
- **lib/process_queue**: Aynı tick'te birden fazla `delay=0` item varsa hepsi işleniyor.
