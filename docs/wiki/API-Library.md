# 🔁 Library — `macro:lib/*`

← [Home](Home)

---

## Iteration

| Function | Input | Description |
|----------|-------|-------------|
| `lib/for_each_player` | `{func}` | Run function as each online player |
| `lib/for_each_player_at` | `{func}` | Run function as each online player at their location |
| `lib/for_each_list` | `{func}` + `macro:engine _felist_input` list | Iterate a list, running function for each entry with macro expansion |
| `lib/repeat` | `{func, count}` | Run function exactly `count` times |

## Scheduling & Queues

| Function | Input | Description |
|----------|-------|-------------|
| `lib/wait` | `{func, delay}` | Run function after `delay` ticks (alias: `lib/queue_add`) |
| `lib/wait_cmd` | `{cmd, delay}` | Run command after `delay` ticks |
| `lib/schedule` | `{key, func, interval}` | Repeating timer — re-calling same key auto-resets |
| `lib/schedule_cmd` | `{key, cmd, interval}` | Repeating timer with raw command |
| `lib/schedule_renew` | `{key}` | Extend existing schedule without reset |
| `lib/schedule_reset` | `{key}` | Cancel and restart a schedule |
| `lib/schedule_list` | — | Show active schedules to `macro.debug` |
| `lib/queue_add` | `{func, delay}` | Add function to deferred queue |
| `lib/queue_add_cmd` | `{cmd, delay}` | Add command to deferred queue |
| `lib/queue_clear` | — | Clear entire queue |
| `lib/once` | `{key, func}` | Run function only the first time this key is called |
| `lib/once_cmd` | `{key, cmd}` | Same but for commands |
| `lib/throttle` | `{key, func, interval}` | Call at most once per `interval` ticks |
| `lib/debounce` | `{key, func, interval}` | Run only after `interval` ticks of inactivity |
| `lib/debounce_cmd` | `{key, cmd, interval}` | Debounce with raw command |

## Input Stack

| Function | Description |
|----------|-------------|
| `lib/input_push` | Save current `macro:input` state |
| `lib/input_pop` | Restore previously saved `macro:input` state |

## Cooperative Concurrency — `lib/fiber/*`

| Function | Input | Description |
|----------|-------|-------------|
| `lib/fiber/spawn` | `{id, func, state}` | Create a new fiber |
| `lib/fiber/yield` | `{id}` | Pause fiber until next tick |
| `lib/fiber/resume` | `{id}` | Resume a paused fiber |
| `lib/fiber/kill` | `{id}` | Terminate a fiber |
| `lib/fiber/is_alive` | `{id}` | Returns `result:1b` if fiber is running |

## Batch Processing — `lib/batch/*`

Spread heavy work across multiple ticks.

| Function | Input | Description |
|----------|-------|-------------|
| `lib/batch/begin` | `{id, items}` | Initialize batch with item list |
| `lib/batch/add` | `{id, item}` | Add item to existing batch |
| `lib/batch/flush` | `{id, func, rate}` | Process `rate` items per tick, calling `func` for each |
| `lib/batch/cancel` | `{id}` | Cancel a batch |

## Tick Guard

| Function | Description |
|----------|-------------|
| `lib/tick_guard` | Per-entity tick-unique execution gate. Returns 0 if already called this tick for `@s`. |
| `lib/tick_guard_clear` | Manually reset guard for `@s` |

---

## Examples

### Repeat for each player

```mcfunction
data modify storage macro:input func set value "mypack:daily/reward"
function macro:lib/for_each_player with storage macro:input {}
```

### Delayed execution

```mcfunction
# Run "mypack:announce/event_start" after 3 seconds
data modify storage macro:input func set value "mypack:announce/event_start"
data modify storage macro:input delay set value 60
function macro:lib/wait with storage macro:input {}
```

### Repeating schedule (auto-resets on re-call)

```mcfunction
# Timer fires every 20 ticks; re-calling with same key auto-resets
data modify storage macro:input key set value "my_timer"
data modify storage macro:input func set value "mypack:tick_event"
data modify storage macro:input interval set value 20
function macro:lib/schedule with storage macro:input {}

# Cancel
data modify storage macro:input key set value "my_timer"
function macro:lib/schedule_reset with storage macro:input {}
```

### Throttle (rate limit a noisy trigger)

```mcfunction
# Only fires once per 10 ticks no matter how often this is called
data modify storage macro:input key set value "mypack.chat_trigger"
data modify storage macro:input func set value "mypack:chat/handle"
data modify storage macro:input interval set value 10
function macro:lib/throttle with storage macro:input {}
```

### Batch processing

```mcfunction
# Process 1000 players in batches of 5 per tick
data modify storage macro:input id set value "mypack.rewards"
data modify storage macro:input items set value ["Steve","Alex","Notch"]  # your list
function macro:lib/batch/begin with storage macro:input {}

data modify storage macro:input func set value "mypack:reward/give_one"
data modify storage macro:input rate set value 5
function macro:lib/batch/flush with storage macro:input {}
```
