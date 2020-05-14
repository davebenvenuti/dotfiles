PROMPT='%{$fg_bold[yellow]%}%m %{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info) $(kubectl_prompt_info) % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

ZSH_THEME_KUBECTL_PROMPT_PREFIX="%{$fg[green]%}k8s:(%{$fg[magenta]%}"
ZSH_THEME_KUBECTL_PROMPT_SUFFIX="%{$fg[green]%})%{$reset_color%}"
