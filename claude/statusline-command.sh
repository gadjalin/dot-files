#!/usr/bin/env bash
# Claude Code status line
# Recreated in the spirit of the user's fish "tide" prompt (context, pwd, git, character)
# since fish does not use a PS1 variable.

input=$(cat)

cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir')
model=$(printf '%s' "$input" | jq -r '.model.display_name')
style=$(printf '%s' "$input" | jq -r '.output_style.name // empty')
used=$(printf '%s' "$input" | jq -r '.context_window.used_percentage // empty')
usg=$(printf '%s' "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
usg7=$(printf '%s' "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

branch=""
if git -C "$cwd" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
  dirty=""
  if [ -n "$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)" ]; then
    dirty="*"
  fi
fi

# Color codes are defined with ANSI-C quoting ($'...') so the variables hold
# real ESC bytes. That way they print correctly whether they end up inside a
# printf format string or passed as a plain %s/%b argument.
MAGENTA=$'\033[35m'
CYAN=$'\033[36m'
BRGREEN=$'\033[92m'
BLUE=$'\033[34m'
LIGHTBLUE=$'\033[94m'
ORANGE=$'\033[38;5;208m'
RED=$'\033[91m'
RESET=$'\033[0m'

# Minimum field widths (left-justified, padded with spaces).
DIR_W=35
DIR_MAXLEN=40
BRANCH_W=15
MODEL_W=12
BAR_W=20
CTX_W=$((BAR_W + 12))
USG_BAR_W=10
USG_W=$((USG_BAR_W + 18))

pad() {
  # $1 = text, $2 = min width
  printf '%-*s' "$2" "$1"
}

# Replace $HOME with ~ in the current directory path.
dir_full="$cwd"
case "$dir_full" in
  "$HOME") dir_full="~" ;;
  "$HOME"/*) dir_full="~${dir_full#"$HOME"}" ;;
esac

# If the (already ~-shortened) path is still long, abbreviate every
# intermediate component down to its first character, keeping the leading
# marker (~ or /) and the final component intact for readability.
dir="$dir_full"
if [ "${#dir_full}" -gt "$DIR_MAXLEN" ]; then
  IFS='/' read -ra dir_parts <<< "$dir_full"
  n=${#dir_parts[@]}
  abbrev=""
  for i in "${!dir_parts[@]}"; do
    seg="${dir_parts[$i]}"
    if [ "$i" -eq 0 ]; then
      abbrev="$seg"
    elif [ "$i" -eq $((n - 1)) ]; then
      abbrev="${abbrev}/${seg}"
    else
      abbrev="${abbrev}/${seg:0:1}"
    fi
  done
  dir="$abbrev"
fi

dir_text=$(pad "$dir" "$DIR_W")

modelfull="$model"
if [ -n "$style" ] && [ "$style" != "default" ]; then
  modelfull="$model ($style)"
fi
model_text=$(pad "$modelfull" "$MODEL_W")

# Build the context usage bar.
ctx_text=""
if [ -n "$used" ]; then
  # Round used percentage and bar fill to nearest integer.
  used_int=$(awk -v u="$used" 'BEGIN{printf "%d", (u+0.5)}')
  filled=$(awk -v u="$used" -v w="$BAR_W" 'BEGIN{
    f = (u * w / 100) + 0.5;
    if (f > w) f = w;
    if (f < 0) f = 0;
    printf "%d", f
  }')
  empty=$((BAR_W - filled))

  bar_filled=$(printf '%*s' "$filled" '' | tr ' ' '#')
  bar_empty=$(printf '%*s' "$empty" '' | tr ' ' '-')
  bar="[${bar_filled}${bar_empty}]"

  if [ "$used_int" -ge 80 ]; then
    ctx_color="$RED"
  elif [ "$used_int" -ge 30 ]; then
    ctx_color="$ORANGE"
  else
    ctx_color="$LIGHTBLUE"
  fi

  ctx_plain="ctx ${bar} ${used_int}%"
  # Colorize only the bar portion within the padded text.
  ctx_prefix="ctx "
  ctx_suffix=" ${used_int}%"
  # Recompute padding around the colored bar so alignment stays correct.
  plain_len=${#ctx_plain}
  pad_len=$((CTX_W - plain_len))
  if [ "$pad_len" -lt 0 ]; then
    pad_len=0
  fi
  pad_spaces=$(printf '%*s' "$pad_len" '')
  ctx_text="${ctx_prefix}${ctx_color}${bar}${RESET}${ctx_suffix}${pad_spaces}"
fi

# Build the subscription usage bar (5-hour rate limit window).
usg_text=""
if [ -n "$usg" ]; then
  usg_filled=$(awk -v u="$usg" -v w="$USG_BAR_W" 'BEGIN{
    f = (u * w / 100) + 0.5;
    if (f > w) f = w;
    if (f < 0) f = 0;
    printf "%d", f
  }')
  usg_empty=$((USG_BAR_W - usg_filled))
  usg_bar="[$(printf '%*s' "$usg_filled" '' | tr ' ' '#')$(printf '%*s' "$usg_empty" '' | tr ' ' '-')]"
  usg_pct=$(awk -v u="$usg" 'BEGIN{printf "%d", (u+0.5)}')

  # Thresholds: >= 85% red, >= 60% orange, else light blue.
  usg_color=$(awk -v u="$usg" -v r="$RED" -v o="$ORANGE" -v b="$LIGHTBLUE" \
    'BEGIN{ if (u >= 85) printf "%s", r; else if (u >= 60) printf "%s", o; else printf "%s", b }')

  # Percentage text: "5h" and optionally " / 7d", both whole numbers.
  usg_pcts="${usg_pct}%"
  if [ -n "$usg7" ]; then
    usg7_int=$(awk -v u="$usg7" 'BEGIN{printf "%d", (u+0.5)}')
    usg_pcts="${usg_pcts} / ${usg7_int}%"
  fi

  usg_plain="usg ${usg_bar} ${usg_pcts}"
  usg_pad=$((USG_W - ${#usg_plain}))
  [ "$usg_pad" -lt 0 ] && usg_pad=0
  usg_text="usg ${usg_color}${usg_bar}${RESET} ${usg_pcts}$(printf '%*s' "$usg_pad" '')"
fi

branch_text=""
if [ -n "$branch" ]; then
  branch_text=$(pad "${branch}${dirty}" "$BRANCH_W")
fi

now=$(date +%H:%M)

printf "${MAGENTA}\$${RESET} "
printf "${CYAN}%s${RESET}" "$dir_text"

if [ -n "$branch" ]; then
  printf " | ${BRGREEN}%s${RESET}" "$branch_text"
fi

printf " | ${BLUE}%s${RESET}" "$model_text"

if [ -n "$ctx_text" ]; then
  printf " | %s" "$ctx_text"
fi

if [ -n "$usg_text" ]; then
  printf " | %s" "$usg_text"
fi

printf " | %s" "$now"

printf "\n"
