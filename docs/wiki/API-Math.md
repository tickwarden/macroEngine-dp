# 🔢 Math — `macro:math/*`

← [Home](Home)

---

## API

| Function | Input | Output | Description |
|----------|-------|--------|-------------|
| `math/sign` | `{value}` | -1 / 0 / 1 | Sign of a number |
| `math/sign_nonzero` | `{value}` | -1 / 1 | Sign without zero (negatives → -1, zero and above → 1) |
| `math/abs` | `{value}` | `\|value\|` | Absolute value |
| `math/clamp` | `{value, min, max}` | `result` in [min, max] | Clamp to range |
| `math/min` | `{a, b}` | `result` | Minimum of two values |
| `math/max` | `{a, b}` | `result` | Maximum of two values |
| `math/minmax` | `{a, b}` | `{min, max}` | Both min and max in one call |
| `math/lerp` | `{a, b, t}` | `a + (b-a)*t/100` | Linear interpolation (t: 0–100) |
| `math/lerp_clamped` | `{a, b, t}` | clamped lerp | Lerp with t clamped to [0, 100] |
| `math/map` | `{value, in_min, in_max, out_min, out_max}` | `result` | Map value from one range to another |
| `math/wrap` | `{value, min, max}` | `result` | Wrap value within [min, max) |
| `math/sqrt` | `{value}` | `floor(√value)` | Integer square root (binary search, 16 iter) |
| `math/ceil_div` | `{a, b}` | `⌈a/b⌉` | Ceiling division |
| `math/divmod` | `{value, divisor}` | `{quotient, remainder}` | Division and safe modulo in one call |
| `math/mod` | `{value, divisor}` | `result` in [0, divisor) | Safe modulo (always positive) |
| `math/pow` | `{base, exp}` | `result` | Integer exponentiation |
| `math/log2` | `{value}` | `floor(log₂(value))` | Integer log base 2 |
| `math/round` | `{value, step}` | `result` | Round to nearest multiple of `step` |
| `math/distance2d` | `{x1, z1, x2, z2}` | `floor(√(dx²+dz²))` | XZ distance |
| `math/mul_div` | `{a, b, c}` | `floor(a*b/c)` | Overflow-safe multiply-divide |
| `math/random` | `{min, max}` | `result` in [min, max] | Pseudo-random integer (LCG, unbiased) |

### 3D Vector Math — `math/vec/*`

| Function | Input | Output | Description |
|----------|-------|--------|-------------|
| `math/vec/add` | `{ax,ay,az, bx,by,bz}` | `{rx,ry,rz}` | Vector addition |
| `math/vec/sub` | `{ax,ay,az, bx,by,bz}` | `{rx,ry,rz}` | Vector subtraction |
| `math/vec/dot` | `{ax,ay,az, bx,by,bz}` | `result` | Dot product |
| `math/vec/cross` | `{ax,ay,az, bx,by,bz}` | `{rx,ry,rz}` | Cross product |
| `math/vec/normalize` | `{ax,ay,az}` | `{rx,ry,rz}` | Normalize to unit vector (×1000 fixed-point) |
| `math/vec/angle_between` | `{ax,ay,az, bx,by,bz}` | `result` (degrees) | Angle between two vectors |

---

## Examples

### Distance check

```mcfunction
data modify storage macro:input x1 set value 0
data modify storage macro:input z1 set value 0
data modify storage macro:input x2 set value 30
data modify storage macro:input z2 set value 40
function macro:math/distance2d with storage macro:input {}
# output.result → 50
```

### Health percentage (lerp)

```mcfunction
# Scale HP (0–20) to power (0–100)
data modify storage macro:input a set value 0
data modify storage macro:input b set value 100
data modify storage macro:input t set value 75    # 75% HP
function macro:math/lerp with storage macro:input {}
# output.result → 75
```

### Safe random in range

```mcfunction
data modify storage macro:input min set value 1
data modify storage macro:input max set value 6
function macro:math/random with storage macro:input {}
# output.result → 1..6 (uniform, unbiased)
```

### Overflow-safe multiply-divide

```mcfunction
# Calculate 50000 * 3 / 7 without overflow
data modify storage macro:input a set value 50000
data modify storage macro:input b set value 3
data modify storage macro:input c set value 7
function macro:math/mul_div with storage macro:input {}
# output.result → 21428
```

### Using input_push to nest math calls

```mcfunction
function macro:lib/input_push          # save current macro:input

data modify storage macro:input value set value 144
function macro:math/sqrt with storage macro:input {}
# output.result → 12

function macro:lib/input_pop           # restore macro:input
```
