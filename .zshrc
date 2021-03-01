# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="clean"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
git
dotenv
kubectl
asdf
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# NVM stuff
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias weather='_weather(){ curl -s https://wttr.in/${1:-denver}; }; _weather'
alias dockerpgstart='docker run --rm --name pg-docker -e POSTGRES_PASSWORD=docker -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres:11.8'
alias dockerpsql='docker exec -it pg-docker psql "host=localhost user=postgres password=docker"'
alias testfw='go test ./pkg/... -p 1 -coverprofile=coverage.txt -covermode=atomic --tags=integration'
alias fwuitest='npx vue-cli-service test:e2e --url http://localhost:3000/'
alias goose='/Users/jordandoig/go/bin/goose'
alias gorm-goose='/Users/jordandoig/go/bin/gorm-goose'
alias gpd='git push origin --delete'
alias gbD='git branch -D'
alias k='kubectl'
alias fwctl='cuddlectl use reactiveops.com'
alias fwop='eval $(op signin reactiveops)'
alias fwi='cd ~/go/src/Fairwinds/Insights'
alias fww='cd ~/go/src/Fairwinds/Insights/web'
alias fwapi='go run main.go --port 3000'
alias fwclient='npm run build && npm run watch'
alias da='direnv allow'
alias kns='kubectl config set-context --current --namespace'

# replace all occurences in directory recursively
# eg. replaceall pkg/ 's/toBeReplaced/newGoodStuff/'
function replaceall() {
  find "${1}" -type f -exec sed -i -e "${2}" {} \;
}

export GOPATH=$HOME/go

# Hook up direnv
eval "$(direnv hook zsh)"
ZSH_DOTENV_FILE=.envrc

# Cuddlefish things
source ~/.cuddlefish/config
source <(kubectl completion zsh)

# Kube info plugin
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
PROMPT='$(kube_ps1)'$PROMPT

# Runner autocomplete?
eval $(runner --completion=bash)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jordandoig/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jordandoig/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jordandoig/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jordandoig/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

fpath=(/Users/jordandoig/.asdf/completions /Users/jordandoig/.oh-my-zsh/plugins/asdf /Users/jordandoig/.oh-my-zsh/plugins/kubectl /Users/jordandoig/.oh-my-zsh/plugins/dotenv /Users/jordandoig/.oh-my-zsh/plugins/git /Users/jordandoig/.oh-my-zsh/functions /Users/jordandoig/.oh-my-zsh/completions /usr/local/share/zsh/site-functions /usr/share/zsh/site-functions /usr/share/zsh/5.8/functions)

autoload -Uz compinit && compinit

# Add local go to PATH for reasons
export PATH="$PATH:$HOME/go/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# dropbox code - 0kzaxmnv
export PATH="/usr/local/opt/postgresql@11/bin:$PATH"

. /usr/local/opt/asdf/asdf.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
