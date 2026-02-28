# Advanced Macro Engine — Changelog

## v3.4

### 🐛 Bug Fixes & İyileştirmeler
- **load/warn**: Sunucu başlarken oyuncu yoksa `macro:load` direkt çalışır, gereksiz dialog satırına geçmez (`return run` ile)
- **load/warn**: `@p` yerine `@a` — tüm çevrimiçi oyunculara uyarı gösterilir

### ✨ Yeni: `load/warn.mcfunction`
Sunucu yüklenirken deneysel özellikler hakkında oyuncuları bilgilendiren onay dialogu.
- Oyuncu yoksa: `macro:load` direkt çalışır
- Oyuncu varsa: "Çıkış Yap" veya "Devam Et" seçenekli dialog gösterilir

### 🔧 Versiyon Tutarlılığı
- `load.mcfunction`, `pack.mcmeta` ve storage versiyonları `v3.4` ile eşleştirildi

---

## v3.3 (Geliştirme)

### 📦 Yeni: `data/macro/damage_type/`
Özel hasar tipi JSON'ları. `macro:cmd/damage_typed` ile kullanılır.

| Dosya | `message_id` | Efekt | Scaling |
|---|---|---|---|
| `macro:magic` | magic | none | never |
| `macro:true_damage` | generic | none | never |
| `macro:void_custom` | outOfWorld | none | never |
| `macro:fire_custom` | inFire | burning | when_caused_by_living_non_player |
| `macro:wither_custom` | wither | wither | never |

### 📦 Yeni: `data/macro/item_modifier/`
Hazır item modifier JSON'ları. `macro:cmd/item_modify` ile uygulanır.

| Dosya | Etki |
|---|---|
| `repair_full` | Hasarı sıfırla (tam tamir) |
| `damage_random` | Rastgele hasar uygula |
| `enchant_randomly` | Rastgele büyü ekle (`#on_random_loot`) |
| `enchant_with_levels_5` | 5 seviye büyü ekle |
| `enchant_with_levels_30` | 30 seviye büyü ekle |
| `set_count_1` / `set_count_64` | Miktar ayarla |
| `lore_add_custom` | Lore satırı ekle (append) |
| `lore_clear` | Tüm lore'u sil |
| `glint_add` / `glint_remove` | Büyü parlaması aç/kapat |
| `unbreakable` | Kırılmaz yap |
| `hide_tooltip` | Tooltip'i gizle |
| `rename_to_custom` | "Custom Item" olarak yeniden adlandır (şablon) |

### 📦 Yeni: `data/macro/loot_table/`
Hazır loot table şablonları. `macro:cmd/loot_give` ve `macro:cmd/loot_drop` ile kullanılır.

| Dosya | Açıklama |
|---|---|
| `util/empty` | Hiçbir şey düşürme |
| `util/xp_only` | Sadece XP (item yok) |
| `template/single_item` | Tek item — düzenlenebilir şablon |
| `template/weighted_pool` | Ağırlıklı rastgele havuz şablonu |
| `template/conditional_drop` | Yalnızca oyuncu vuruşunda düşür |
| `template/bonus_per_looting` | Looting büyüsüne göre ekstra drop |

### 📦 Yeni: `data/macro/advancement/`
Kolayca kopyalanıp özelleştirilebilen advancement şablonları.

| Dosya | Frame | Toast | Sohbet | XP Ödülü |
|---|---|---|---|---|
| `hidden/root` | task | ✗ | ✗ | — |
| `template/task` | task | ✓ | ✗ | — |
| `template/goal` | goal | ✓ | ✓ | — |
| `template/challenge` | challenge | ✓ | ✓ | 100 |

### ✨ Yeni: `predicate/` Genişlemesi
Mevcut predicate setine eklenenler:

`is_flying`, `is_gliding`, `is_in_water`, `is_baby`, `is_hungry`,  
`is_holding_sword`, `is_holding_bow`, `is_holding_trident`,  
`has_empty_offhand`, `weather_clear`, `health_below_half`

### ✨ Yeni: `cmd/` Fonksiyonları
| Fonksiyon | Açıklama |
|---|---|
| `cmd/attribute_add_modifier` | Attribute modifier ekle (add_value / multiplied) |
| `cmd/attribute_remove_modifier` | Attribute modifier kaldır (id ile) |
| `cmd/attribute_get_modifier` | Belirli modifier değerini oku |
| `cmd/damage_typed` | Özel `damage_type` ile hasar ver |
| `cmd/item_modify` | Slot'a item_modifier uygula |
| `cmd/item_rename` | Slot'a rename modifier uygula |
| `cmd/loot_drop` | Koordinata loot table'dan item düşür |
| `cmd/loot_give` | Oyuncuya loot table içeriğini ver |
| `cmd/advancement_grant` | Oyuncuya advancement ver |
| `cmd/advancement_revoke` | Oyuncudan advancement al |
| `cmd/advancement_check` | Advancement var mı kontrol et → `1b/0b` |

### ✨ Yeni: `string/` Fonksiyonları
| Fonksiyon | Açıklama |
|---|---|
| `string/hover_text` | Hover'da açıklama gösteren tellraw |
| `string/click_run` | Tıklanınca komut çalıştıran buton |
| `string/click_suggest` | Tıklanınca sohbete metin öneren buton |
| `string/link` | Tıklanınca URL açan bağlantı metni |
| `string/copy_to_clipboard` | Tıklanınca panoya kopyalayan buton |
| `string/announce_prefix` | `[PREFIX] mesaj` formatında duyuru |
| `string/tooltip_item` | Hover'da item tooltip gösteren metin |

---

## v3.2

### 🐛 Bug Fixes
- **math/random**: `$epoch=0` durumunda LCG tohumunun zayıf kalması giderildi. 57005 (0xDEAD) sabit ofseti eklendi.

### ✨ Yeni: Event Sistemi
`event/unregister_one`, `event/has`, `event/count`, `event/clear_context`, `event/fire_queued`

### ✨ Yeni: Queue / Zamanlama
`lib/queue_clear`, `lib/schedule_list`, `lib/schedule_reset`

### ✨ Yeni: Matematik Kütüphanesi
`math/map`, `math/wrap`, `math/log2`, `math/mod`

### ✨ Yeni Modül: `flag/`
`flag/set`, `flag/unset`, `flag/get`, `flag/toggle`, `flag/list`

### ✨ Yeni Modül: `state/`
`state/set`, `state/get`, `state/is`, `state/clear`, `state/clear_all`, `state/list`

### ✨ Yeni: cmd/ Komutları
`cmd/msg`, `cmd/msg_raw`, `cmd/clone`, `cmd/clone_masked`, `cmd/ride`, `cmd/ride_dismount`,
`cmd/forceload_add`, `cmd/forceload_remove`, `cmd/trigger_set`, `cmd/spectate`, `cmd/spectate_stop`,
`cmd/place_feature`, `cmd/place_structure`

---

## v3.1

### 🐛 Bug Fixes
- **lib/schedule**: Aynı key ile tekrar çağrılınca queue'ya duplicate giriş eklenmesi giderildi.

---

## v3.0

### 🐛 Bug Fixes
- **load**: `$epoch macro.time` artık `/reload`'da sıfırlanmıyor.
- **lib/process_queue**: `$pq_depth` ile tick başına 256 özyineleme limiti eklendi.
- **debug/example_events**: `event_context` path düzeltildi.

---

## v2.5

### 🐛 Bug Fixes
- **lib/process_queue**: Aynı tick'te birden fazla `delay=0` item varsa hepsi işleniyor.
