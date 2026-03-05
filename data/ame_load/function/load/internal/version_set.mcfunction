# ============================================
# ame_load:load/internal/version_set
# ============================================
# Writes current AME version to the ame.pre_version
# scoreboard objective after a successful load.
# Called from all.mcfunction step 6.5.
#
# Scores written:
#   $v_major  ame.pre_version → 1
#   $v_minor  ame.pre_version → 0
#   $v_patch  ame.pre_version → 6
#   $v_pre    ame.pre_version → 1  (pre-release flag; 0 = stable)
#   $ame_ver_set ame.pre_version → 1  (sentinel)
#
# Sentinel semantics:
#   $ame_ver_set = 0 / unset → first run, no conflict check
#   $ame_ver_set = 1          → AME was previously initialized;
#                               validate will compare scores
# ============================================

scoreboard players set $v_major ame.pre_version 1
scoreboard players set $v_minor ame.pre_version 0
scoreboard players set $v_patch ame.pre_version 6
scoreboard players set $v_pre   ame.pre_version 1
scoreboard players set $ame_ver_set ame.pre_version 1
