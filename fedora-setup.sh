#!/bin/sh

#Additional DNF settings
sudo tee -a /etc/dnf/dnf.conf <<EOF
fastestmirror=True
max_parallel_downloads=10
defaultyes=True
keepcache=True
EOF

# Update
sudo dnf update

#Installing essential programs
sudo dnf install \
alacritty \
git \
bat \
jq \
httpie \
zsh \
vim \
gnome-tweaks \
gnome-extensions-app \
remmina \
util-linux-user \
sqlite \
starship \
syncthing \
keepassxc \
dconf-editor \
https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
discord

#Installing Oh-my-ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#Enable flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

#Install Spotify
flatpak install -y spotify

#Install Albert launcher
sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:manuelschneid3r/Fedora_36/home:manuelschneid3r.repo
sudo dnf install albert

#Install VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install code

#Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/bin/

#Install Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm get_helm.sh

#Alacritty config
tee ~/.config/alacritty.yml <<EOF
selection:
  save_to_clipboard: true

window:
  padding:
    x: 5
    y: 5

  opacity: 0.9

font:
  normal:
    family: inconsolata
    style: Regular

  size: 15

cursor:
  style:
    shape: Beam

scrolling:
  history: 10000
  multiplier: 3


colors:
  primary:
    background: '#2e3440'
    foreground: '#d8dee9'
    dim_foreground: '#a5abb6'
  cursor:
    text: '#2e3440'
    cursor: '#d8dee9'
  vi_mode_cursor:
    text: '#2e3440'
    cursor: '#d8dee9'
  selection:
    text: CellForeground
    background: '#4c566a'
  search:
    matches:
      foreground: CellBackground
      background: '#88c0d0'
    bar:
      background: '#434c5e'
      foreground: '#d8dee9'
  normal:
    black: '#3b4252'
    red: '#bf616a'
    green: '#a3be8c'
    yellow: '#ebcb8b'
    blue: '#81a1c1'
    magenta: '#b48ead'
    cyan: '#88c0d0'
    white: '#e5e9f0'
  bright:
    black: '#4c566a'
    red: '#bf616a'
    green: '#a3be8c'
    yellow: '#ebcb8b'
    blue: '#81a1c1'
    magenta: '#b48ead'
    cyan: '#8fbcbb'
    white: '#eceff4'
  dim:
    black: '#373e4d'
    red: '#94545d'
    green: '#809575'
    yellow: '#b29e75'
    blue: '#68809a'
    magenta: '#8c738c'
    cyan: '#6d96a5'
    white: '#aeb3bb'

key_bindings:
  - {key: Return, mods: Super|Shift, action: SpawnNewInstance}
EOF

#ZSH config
tee ~/.zshrc <<EOF
# if you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sudo kubectl terraform)

source $ZSH/oh-my-zsh.sh
source <(kubectl completion zsh)
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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# Custome Aliases
alias dc='docker-compose'
export KUBECONFIG=./kubeconfig
eval "$(starship init zsh)"
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'
alias fjson="jq -R -r -C '. as \$line | try fromjson catch \$line'"
EOF

#Starship config
tee ~/.config/starship.toml <<EOF
format = """
$username\
$hostname\
$shlvl\
$directory\
$kubernetes\
$git_branch\
$git_commit\
$git_state\
$git_status\
$hg_branch\
$package\
$golang\
$helm\
$kotlin\
$nim\
$nodejs\
$rust\
$terraform\
$vagrant\
$nix_shell\
$memory_usage\
$env_var\
$custom\
$cmd_duration\
$line_break\
$lua\
$jobs\
$battery\
$time\
$status\
$character"""

# Don't print a new line at the start of the prompt
add_newline = false

# Replace the "❯" symbol in the prompt with "➜"
[character]                            # The name of the module we are configuring is "character"
success_symbol = "[➜](bold green)"     # The "success_symbol" segment is being set to "➜" with the color "bold green"
error_symbol = "[➜](bold red)"     # The "success_symbol" segment is being set to "➜" with the color "bold green"

[directory]
truncation_length = 3
truncation_symbol = "…/"

[kubernetes]
format = '[$symbol\[$namespace\] $context](blue) '
disabled = false
EOF

#Install docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo systemctl start docker

sudo usermod -aG docker $USER