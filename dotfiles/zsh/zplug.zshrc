export ZPLUG_ROOT="$HOME/.zplug"

source "$ZPLUG_ROOT/init.zsh"

# theme
zplug 'agnoster/agnoster-zsh-theme', as:theme

# other plugins
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

zplug 'atuinsh/atuin'
zplug 'wfxr/forgit'

zplug 'plugins/catimg', from:oh-my-zsh
zplug 'plugins/direnv', from:oh-my-zsh
zplug 'plugins/ssh-agent', from:oh-my-zsh
zplug 'plugins/zoxide', from:oh-my-zsh

# install plugins if not installed
if ! zplug check; then
 zplug install
fi

# load plugins
zplug load
