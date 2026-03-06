# 🔧 Advanced Macro Engine — v1.0.5
**Minecraft Java Edition 1.21.x | Multiplayer-Safe | Pure Datapack**

---

## 🩹 v2.4 Bug Fix Notları

| Bug | Dosya | Düzeltme |
|-----|-------|---------|
| **KRİTİK**: Cooldown'lar hiç dolmuyordu | `cooldown/set/check/remaining` | `$tick macro.tmp` (0-20 arası sıfırlanan sayaç) yerine yeni `$epoch macro.time` (mutlak, hiç sıfırlanmaz) kullanılıyor |
| Tick'te yeni `scoreboard objectives add macro.time` | `load.mcfunction`, `tick.mcfunction` | `macro.time` objective eklendi; `$epoch macro.time` her tick +1, /reload'da sıfırlanmaz |
| `progress_bar` görsel blok yerine ham sayı gösteriyordu | `string/progress_bar` | 11'li lookup tablosu: `█░` karakterleri gerçek olarak render ediliyor |
| `fire_next` NBT predicate yanlıştı | `event/internal/fire_next` | `{event_queue:[{}]}` root filter → `event_queue[0]` path kontrolü |
| `process_queue` + `tick` aynı sorun | `lib/process_queue`, `tick` | `{queue:[{}]}` → `queue[0]` |
| `distance2d`, `sqrt` için `macro:input.value` yazarak caller input'u bozuyordu | `math/distance2d` | sqrt mantığı inline çalışıyor, `macro:input` artık kirlenmez |
| `ceil_div`'de `$cd_1` ismi cooldown prefix'iyle çakışıyordu | `math/ceil_div` | `$cd_1` → `$cdv_1`, `$a/$b` → `$cdv_a/$cdv_b` |
| `load.mcfunction` başlık yorumu "v2.1" diyordu | `load.mcfunction` | Güncellendi |
| `sync_tick` global epoch'u storage'a yazmıyordu | `lib/sync_tick` | `global.epoch` de sync ediliyor |

---

## 🆕 v2.3 Yeni Sistem ve Komutlar

| Modül | Eklenenler |
|-------|-----------|
| `cooldown/` | 5 fonksiyon — tick tabanlı cooldown sistemi |
| `event/` | 5 fonksiyon — dinamik event/hook sistemi |
| `lib/` | `for_each_player`, `for_each_player_at`, `repeat`, `wait` |
| `math/` | `sign`, `lerp`, `sqrt`, `ceil_div`, `distance2d` |
| `cmd/` | `kill`, `damage`, `heal`, `particle`, `clear`, `clear_item`, `tag_add`, `tag_remove`, `scoreboard_set/get/add`, `title_times`, `title_reset`, `title_clear` |
| `string/` | `chat`, `broadcast_raw`, `player_raw`, `progress_bar`, `header` |
| `player/` | `reset`, `list_vars`, `add_default`, `increment`, `decrement` |

---

## 🩹 v2.2 Bug Fix Notları

| Bug | Düzeltme |
|-----|----------|
| `load`: `data remove storage macro:input {}` geçersiz | `data modify ... set value {}` |
| `cmd/title_sub`: subtitle rengi hardcoded `"gray"` | `"color":"$(color)"` ile dinamik |
| `cmd/as_player` vb.: `val` parametresi tutarsızlığı | `val` → `func`, diğer API'larla tutarlı |
| `debug/show_all`: `nbt:""` boş path geçersiz | Bölümlere ayrıldı |

---

## 📦 Kurulum

```
1. advanced_macro_engine_v23/ → sunucu/datapacks/ klasörüne koy
2. /reload
3. Debug: /function macro:debug/toggle
```

---

## 🏗️ Storage Mimarisi

```
macro:engine  (kalıcı veri)
├── global
│   ├── version: "2.3"
│   └── tick: <int>
├── players
│   └── Steve { coins:150, level:5, xp:2300, online:1b, ... }
├── queue
│   └── [{func:"mypack:event/end", delay:100}]
├── cooldowns
│   └── Steve { fireball: 2460, dash: 1870 }  ← expiry tick'leri
└── events
    └── on_join: [{func:"mypack:welcome"}, {func:"mypack:xp_bonus"}]

macro:input   (fonksiyona veri gönderme)
macro:output  (fonksiyondan sonuç alma)
```

---

## 🔍 Predicate Sistemi — `macro:predicate/*`

`execute if predicate <id>` komutuyla kullanılır.  
`execute as @a if predicate macro:is_sneaking` gibi herhangi bir kontekstte çalışır.

| Predicate ID | Açıklama |
|---|---|
| `macro:is_survival` | Oyuncu survival modda mı? |
| `macro:is_creative` | Oyuncu creative modda mı? |
| `macro:has_empty_mainhand` | Ana eldeki eşya boş mu? |
| `macro:is_full_health` | Oyuncu tam canda mı? (20 HP) |
| `macro:is_sneaking` | Oyuncu sinsi mi? |
| `macro:is_sprinting` | Oyuncu koşuyor mu? |
| `macro:is_burning` | Oyuncu yanıyor mu? |
| `macro:is_on_ground` | Oyuncu yerde mi? |
| `macro:is_daytime` | Gündüz mü? (0–12000 tick) |
| `macro:is_raining` | Yağmur yağıyor mu? |
| `macro:is_thundering` | Gök gürültülü fırtına mı? |
| `macro:in_overworld` | Üst dünya mı? |
| `macro:in_nether` | Nether mi? |
| `macro:in_end` | End mi? |

### Kullanım Örnekleri

```mcfunction
# Sadece yağmurda ve hayatta kalma modunda çalışır
execute as @a if predicate macro:is_survival if predicate macro:is_raining run function mypack:rain_effect

# Yerde değilse (uçuyor/düşüyor) ses çal
execute as @a unless predicate macro:is_on_ground run function mypack:air_sound

# Tam canlıyken bonus ver
execute as @a if predicate macro:is_full_health run function mypack:full_health_bonus

# Nether'dayken sinsi oyuncuya particles
execute as @a if predicate macro:in_nether if predicate macro:is_sneaking run particle minecraft:soul_fire_flame ~ ~1 ~
```

---

## 📚 API Referansı

### 🕐 Cooldown — `macro:cooldown/*`

| Fonksiyon | Input | Açıklama |
|-----------|-------|---------|
| `cooldown/set` | `{player, key, duration}` | Cooldown başlat (duration = tick) |
| `cooldown/check` | `{player, key}` | `output.result` = 1b (hazır) / 0b (aktif) |
| `cooldown/remaining` | `{player, key}` | `output.result` = kalan tick (0 = dolmuş) |
| `cooldown/clear` | `{player, key}` | Belirli cooldown'u sıfırla |
| `cooldown/clear_all` | `{player}` | Tüm cooldown'ları sıfırla |

**Örnek — Yetenek cooldown:**
```mcfunction
# Cooldown kontrolü
data modify storage macro:input player set value "Steve"
data modify storage macro:input key set value "fireball"
function macro:cooldown/check with storage macro:input {}

execute if data storage macro:output {result:1b} run function mypack:ability/fireball_use
execute if data storage macro:output {result:0b} run function mypack:ability/fireball_busy

# Yeteneği kullandıktan sonra cooldown başlat (100 tick = 5sn)
data modify storage macro:input duration set value 100
function macro:cooldown/set with storage macro:input {}
```

---

### 📡 Event — `macro:event/*`

| Fonksiyon | Input | Açıklama |
|-----------|-------|---------|
| `event/register` | `{event, func}` | Event'e handler ekle |
| `event/fire` | `{event}` | Tüm handler'ları çalıştır |
| `event/unregister` | `{event}` | Event'in tüm handler'larını sil |
| `event/list` | — | Kayıtlı event'leri debug'a göster |

**Handler'lara context geçirme:**
```mcfunction
# Önce context'i ayarla (handler'lar okuyabilir)
data modify storage macro:engine event_context player set value "Steve"
data modify storage macro:engine event_context reason set value "login"

# Event'i tetikle
data modify storage macro:input event set value "on_join"
function macro:event/fire with storage macro:input {}
```

**Handler içinde context okuma:**
```mcfunction
# mypack:handlers/on_join.mcfunction
# macro:engine event_context.player → katılan oyuncu
tellraw @a {"storage":"macro:engine","nbt":"event_context.player","interpret":false}
```

---

### 🔁 Lib (Ek) — `macro:lib/*`

| Fonksiyon | Input | Açıklama |
|-----------|-------|---------|
| `lib/for_each_player` | `{func}` | Her online oyuncu OLARAK çalıştır |
| `lib/for_each_player_at` | `{func}` | Her oyuncu olarak ve konumunda |
| `lib/repeat` | `{func, count}` | Fonksiyonu N kez çalıştır |
| `lib/wait` | `{func, delay}` | `queue_add` için kısayol alias |

**Örnek — Tüm oyunculara efekt:**
```mcfunction
# Her oyuncu için başka fonksiyon çalıştır
data modify storage macro:input func set value "mypack:daily/give_bonus"
function macro:lib/for_each_player with storage macro:input {}

# Bir döngü 5 kez çalıştır
data modify storage macro:input func set value "mypack:loop/spawn_mob"
data modify storage macro:input count set value 5
function macro:lib/repeat with storage macro:input {}
```

---

### 🔢 Matematik (Ek) — `macro:math/*`

| Fonksiyon | Input | Output |
|-----------|-------|--------|
| `math/sign` | `{value}` | -1, 0 veya 1 |
| `math/lerp` | `{a, b, t}` | `a + (b-a)*t/100` |
| `math/sqrt` | `{value}` | `floor(√value)` |
| `math/ceil_div` | `{a, b}` | `⌈a/b⌉` |
| `math/distance2d` | `{x1,z1, x2,z2}` | `floor(√(dx²+dz²))` |

---

### 👤 Oyuncu (Ek) — `macro:player/*`

| Fonksiyon | Input | Açıklama |
|-----------|-------|---------|
| `player/reset` | `{player}` | Tüm veriyi sil, varsayılanlara dön ⚠️ |
| `player/list_vars` | `{player}` | Tüm değişken ve cooldown'ları göster |
| `player/add_default` | `{player, key, value}` | Yoksa varsayılan yaz |
| `player/increment` | `{player, key}` | Değeri 1 artır |
| `player/decrement` | `{player, key}` | Değeri 1 azalt |

---

### ⚙️ Komutlar (Ek) — `macro:cmd/*`

| Fonksiyon | Input | Açıklama |
|-----------|-------|---------|
| `cmd/kill` | `{player}` | Öldür |
| `cmd/damage` | `{player, amount, type}` | Hasar ver |
| `cmd/heal` | `{player, amount}` | İyileştir (instant_health efekti) |
| `cmd/particle` | `{name,x,y,z,dx,dy,dz,speed,count}` | Parçacık efekti |
| `cmd/clear` | `{player}` | Envanteri temizle |
| `cmd/clear_item` | `{player, item, count}` | Belirli eşyayı kaldır |
| `cmd/tag_add` | `{player, tag}` | Entity tag ekle |
| `cmd/tag_remove` | `{player, tag}` | Entity tag kaldır |
| `cmd/scoreboard_set` | `{player, objective, value}` | Scoreboard değeri yaz |
| `cmd/scoreboard_get` | `{player, objective}` | Scoreboard değeri oku |
| `cmd/scoreboard_add` | `{player, objective, amount}` | Scoreboard değerine ekle |
| `cmd/title_times` | `{player, fade_in, stay, fade_out}` | Title animasyon süresi |
| `cmd/title_reset` | `{player}` | Title süresini sıfırla |
| `cmd/title_clear` | `{player}` | Aktif title'ı kaldır |

---

### 💬 Mesajlaşma (Ek) — `macro:string/*`

| Fonksiyon | Input | Açıklama |
|-----------|-------|---------|
| `string/chat` | `{target, message, color}` | Tek oyuncuya basit mesaj |
| `string/broadcast_raw` | `{json}` | Tüm oyunculara ham JSON |
| `string/player_raw` | `{player, json}` | Tek oyuncuya ham JSON |
| `string/progress_bar` | `{player, current, max, label}` | Action bar ilerleme çubuğu |
| `string/header` | `{title, color}` | Tüm oyunculara dekoratif başlık |

---

## 🚀 Eksiksiz Örnek — Skill Sistemi

```mcfunction
# Oyuncu "Dash" kullanıyor
data modify storage macro:input player set value "Steve"
data modify storage macro:input key set value "dash"
function macro:cooldown/check with storage macro:input {}

execute if data storage macro:output {result:0b} run function mypack:skill/dash_busy
execute if data storage macro:output {result:1b} run function mypack:skill/dash_use

# mypack:skill/dash_use.mcfunction
execute as @a[name=Steve,limit=1] at @s run effect give @s minecraft:speed 2 3 true
data modify storage macro:input player set value "Steve"
data modify storage macro:input key set value "dash"
data modify storage macro:input duration set value 200
function macro:cooldown/set with storage macro:input {}

# mypack:skill/dash_busy.mcfunction
data modify storage macro:input player set value "Steve"
data modify storage macro:input key set value "dash"
function macro:cooldown/remaining with storage macro:input {}
# output.result → kalan tick
```

---

## 🚀 Eksiksiz Örnek — PvP Etkinlik Sonu

```mcfunction
# Etkinlik bitince tüm oyunculara ödül ver
data modify storage macro:input func set value "mypack:event/give_reward"
function macro:lib/for_each_player with storage macro:input {}

# Bitiş duyurusu
data modify storage macro:input title set value "ETKİNLİK BİTTİ"
data modify storage macro:input subtitle set value "Tebrikler!"
data modify storage macro:input color set value "gold"
# title_times → title → sonra temizle (5sn sonra)
data modify storage macro:input player set value "@a"
data modify storage macro:input fade_in set value 10
data modify storage macro:input stay set value 100
data modify storage macro:input fade_out set value 20
# ... (her oyuncu için döngü veya broadcast)

# 5sn sonra lobi'ye gönder
data modify storage macro:input func set value "mypack:event/send_lobby"
data modify storage macro:input delay set value 100
function macro:lib/wait with storage macro:input {}
```

---

*Advanced Macro Engine v3.0 | MC Java 1.21.x | +2 yeni sistem | +40 yeni fonksiyon*

---

## 🆕 v3.0 Yeni Sistem ve Düzeltmeler

### 🐛 Bug Fix Notları

| Bug | Dosya | Düzeltme |
|-----|-------|---------|
| **KRİTİK**: `/reload`'da `$epoch` sıfırlanıyordu, tüm cooldown'lar geçersiz oluyordu | `load.mcfunction` | `unless score $epoch ... matches -2147483648..2147483647` guard'ı ile sadece hiç oluşturulmamışsa sıfırla |
| `process_queue` özyinelemesi stack overflow riski | `lib/process_queue` | `$pq_depth` sayacı ile tick başına 256 limit; `tick.mcfunction`'da her tick sıfırlanır |
| Version string "v2.1" / "v2.5" tutarsızlığı | `load`, `pack.mcmeta` | Tüm referanslar v3.0 olarak güncellendi |

### 📦 Yeni Modüller

| Modül | Fonksiyonlar |
|-------|-------------|
| `math/` | `sign`, `abs`, `clamp`, `lerp`, `sqrt`, `ceil_div`, `distance2d` + `internal/sqrt_step` |
| `team/` | `create`, `delete`, `add`, `remove`, `has`, `set_color`, `set_friendly_fire`, `count`, `list` |
| `config/` | `set`, `set_int`, `set_default`, `get`, `has`, `delete`, `list`, `reset` |
| `lib/` | `input_push`, `input_pop` (input state koruması) |

---

## 🔢 Matematik — `macro:math/*`

| Fonksiyon | Input | Output | Açıklama |
|-----------|-------|--------|---------|
| `math/sign` | `{value}` | -1 / 0 / 1 | Sayının işareti |
| `math/abs` | `{value}` | \|value\| | Mutlak değer |
| `math/clamp` | `{value, min, max}` | `[min,max]` içinde | Aralığa sıkıştır |
| `math/lerp` | `{a, b, t}` | `a+(b-a)*t/100` | Doğrusal interpolasyon (t: 0-100) |
| `math/sqrt` | `{value}` | `floor(√value)` | Tamsayı karekök (binary search, 16 iter) |
| `math/ceil_div` | `{a, b}` | `⌈a/b⌉` | Tavan bölme |
| `math/distance2d` | `{x1,z1, x2,z2}` | `floor(√(dx²+dz²))` | XZ mesafesi |

**Örnek — Spawn noktasına mesafe:**
```mcfunction
data modify storage macro:input x1 set value 0
data modify storage macro:input z1 set value 0
data modify storage macro:input x2 set value 30
data modify storage macro:input z2 set value 40
function macro:math/distance2d with storage macro:input {}
# output.result → 50
```

**Örnek — Sağlık çubuğu yüzdesi için lerp:**
```mcfunction
# Oyuncunun HP'sine göre bir değeri ölçekle (0 HP=0, 20 HP=100 güç)
data modify storage macro:input a set value 0
data modify storage macro:input b set value 100
data modify storage macro:input t set value 75    # %75 HP
function macro:math/lerp with storage macro:input {}
# output.result → 75
```

---

## 👥 Takım — `macro:team/*`

| Fonksiyon | Input | Açıklama |
|-----------|-------|---------|
| `team/create` | `{team}` | Takım oluştur |
| `team/delete` | `{team}` | Takımı sil |
| `team/add` | `{team, player}` | Oyuncuyu takıma ekle |
| `team/remove` | `{player}` | Oyuncuyu takımdan çıkar |
| `team/has` | `{team, player}` | `output.result` = 1b/0b |
| `team/set_color` | `{team, color}` | Takım rengini ayarla |
| `team/set_friendly_fire` | `{team, value}` | "true" / "false" |
| `team/count` | `{team}` | Online üye sayısı |
| `team/list` | — | Debug'a takım listesi |

**Örnek — PvP harita takım kurulumu:**
```mcfunction
# Takımları kur
data modify storage macro:input team set value "kirmizi"
function macro:team/create with storage macro:input {}
data modify storage macro:input team set value "mavi"
function macro:team/create with storage macro:input {}

# Renk ata
data modify storage macro:input team set value "kirmizi"
data modify storage macro:input color set value "red"
function macro:team/set_color with storage macro:input {}

# Friendly fire kapat
data modify storage macro:input team set value "kirmizi"
data modify storage macro:input value set value "false"
function macro:team/set_friendly_fire with storage macro:input {}

# Oyuncu ekle
data modify storage macro:input team set value "kirmizi"
data modify storage macro:input player set value "Steve"
function macro:team/add with storage macro:input {}

# Takımda mı kontrol et
data modify storage macro:input team set value "kirmizi"
data modify storage macro:input player set value "Steve"
function macro:team/has with storage macro:input {}
execute if data storage macro:output {result:1b} run say Steve kirmizi takımda!
```

---

## ⚙️ Config — `macro:config/*`

| Fonksiyon | Input | Açıklama |
|-----------|-------|---------|
| `config/set` | `{key, value}` | String değer yaz |
| `config/set_int` | `{key, value}` | Tam sayı değer yaz |
| `config/set_default` | `{key, value}` | Yoksa yaz (`output.result` = 1b yeni / 0b vardı) |
| `config/get` | `{key}` | `output.result` = değer (yoksa "") |
| `config/has` | `{key}` | `output.result` = 1b/0b |
| `config/delete` | `{key}` | Key'i sil |
| `config/list` | — | Debug'a tüm config |
| `config/reset` | — | Tüm config'i sil ⚠️ |

**Örnek — Sunucu başlangıcında varsayılan config:**
```mcfunction
# mypack:load.mcfunction — varsayılanları yükle
data modify storage macro:input key   set value "server_name"
data modify storage macro:input value set value "Benim Sunucum"
function macro:config/set_default with storage macro:input {}

data modify storage macro:input key   set value "max_party_size"
data modify storage macro:input value set value 4
function macro:config/set_int with storage macro:input {}   # int versiyonu kullan!

# Çalışma zamanında oku
data modify storage macro:input key set value "max_party_size"
function macro:config/get with storage macro:input {}
# output.result → 4 (veya "Benim Sunucum" string için)
```

---

## 🔒 Input Push/Pop — `macro:lib/input_push` / `input_pop`

Bir fonksiyon içinden başka bir modülü çağırmadan önce `macro:input` durumunu korur.

```mcfunction
# Bir fonksiyon içindeyiz, macro:input dolu
# math/sqrt çağırmamız gerekiyor ama input'u bozmak istemiyoruz

function macro:lib/input_push          # mevcut input'u kaydet

data modify storage macro:input value set value 144
function macro:math/sqrt with storage macro:input {}
# output.result → 12

function macro:lib/input_pop           # input'u geri yükle
# macro:input artık önceki haliyle
```


*Advanced Macro Engine v3.0 | MC Java 1.21.x | +3 yeni modül | +24 yeni fonksiyon | 3 kritik bug fix | Dil: mcfunction*
