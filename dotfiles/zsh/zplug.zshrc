export ZPLUG_ROOT="$HOME/.zplug"

source "$ZPLUG_ROOT/init.zsh"

# theme
zplug 'agnoster/agnoster-zsh-theme', as:theme

# other plugins
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

# install plugins if not installed
if ! zplug check; then
 zplug install
fi

# load plugins
zplug load
