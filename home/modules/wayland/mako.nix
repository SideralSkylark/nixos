{
xdg.configFile."mako/config".text = ''
  # ── Font & layer ──────────────────────────────
  font=JetBrainsMono Nerd Font 12
  layer=overlay
  width=360
  height=120

  # ── Position & sort ───────────────────────────
  anchor=top-right
  max-visible=5
  sort=-time

  # ── Spacing ───────────────────────────────────
  outer-margin=14
  margin=5
  padding=10,14

  # ── Border (sharp retro feel) ─────────────────
  border-size=1
  border-color=#2A2A37
  border-radius=0

  # ── Colors ────────────────────────────────────
  background-color=#1F1F28
  text-color=#DCD7BA

  # ── Format ────────────────────────────────────
  format=<b>%s</b>\n%b
  text-alignment=left
  markup=1

  # ── Behaviour ─────────────────────────────────
  ignore-timeout=0
  default-timeout=5000

  # ── Icons ─────────────────────────────────────
  icons=1
  max-icon-size=28
  icon-location=left
  icon-border-radius=2

  # ── Progress (wave green) ─────────────────────
  progress-color=over #98BB6C66

  # ── Grouping ──────────────────────────────────
  group-by=app-name

  # ── Urgency: low (teal, muted) ────────────────
  [urgency=low]
  background-color=#1F1F28
  text-color=#C8C093
  border-color=#2A2A37
  border-size=1
  default-timeout=3000
  on-notify=none

  # ── Urgency: normal (wave blue) ───────────────
  [urgency=normal]
  background-color=#1F1F28
  text-color=#DCD7BA
  border-color=#7E9CD8
  border-size=2
  default-timeout=5000

  # ── Urgency: critical (red, persistent) ───────
  [urgency=critical]
  background-color=#1F1F28
  text-color=#E46876
  border-color=#E46876
  border-size=2
  default-timeout=0

  # ── Groups (purple, muted) ────────────────────
  [grouped]
  format=(%g) <b>%s</b>\n%b
  border-color=#957FB8
  border-size=2
'';
}
