# Theme with full path names and hostname
# Handy if you work on different servers all the time;

local return_code="%(?..%{$fg[red]%}%?↵ )"

PROMPT=$'%b%{\e[0;33m%}%h %{$fg_bold[cyan]%}%n@%{$fg[yellow]%}%M:%{$fg_bold[green]%} %~ %{$fg_bold[green]%}%(!.#.$) %{$reset_color%}'
RPROMPT=$'$(git_prompt_info) %{$fg[red]%}${return_code}[%*]%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[cyan]%}git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
