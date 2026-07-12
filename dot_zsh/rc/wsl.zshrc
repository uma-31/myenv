function __wezterm_osc7() {
  printf '\e]7;file://localhost%s\e\\' "$PWD"
}

precmd_functions+=(__wezterm_osc7)
