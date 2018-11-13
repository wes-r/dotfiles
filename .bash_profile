# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
	source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# Setup go PATH
export GOPATH=~/go
export PATH=/usr/local/go/bin:$GOPATH/bin:$PATH

# Setup postgres PATH
export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"

# Use custom vim
# export PATH="/opt/local/bin:$PATH"
alias vim="/usr/local/bin/vim"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Setup alias for apptimize local dev activation
alias act='source /ave/bin/activate'
alias super='/ave/bin/supervisorctl -c /opt/etc/supervisord.conf'

export GITHUB_USERNAME='wes-r'
export PYTHONPATH='${PYTHONPATH}:/Users/Wes/freelance/apptimize/qa/'
export PATH="/Users/Wes/freelance/apptimize/frontend/www/node_modules/chromedriver/bin:$PATH"

# Setup yarn
export PATH="$PATH:$HOME/.yarn/bin"

export JAVA_HOME=$(/usr/libexec/java_home)

# pyenv, virtualenv and other python virtual environment stuff
eval "$(pyenv init -)"
export WORKON_HOME=$HOME/.envs
export PYENV_VIRTUALENVWRAPPER_PREFER_PYENV="true"
pyenv virtualenvwrapper


# Auto start ssh-agent via https://stackoverflow.com/a/18915067
# This was needed on OS Lion (10.11) to get git to use stored ssh keys instead of prompting for password every time!
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

export GOOGLE_APPLICATION_CREDENTIALS=/opt/apptimize/keys/googlecloud-dev.json


MYSQL=/usr/local/mysql/bin
export PATH=$PATH:$MYSQL
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRAR

# $HOME/.gem/ruby/RUBYVERSION/bin

export ZEUS_DEFAULT_ENV=staging
export VAULT_ADDR=http://vault.staging.zaius:8200

# Setup and use correct nvm
export NVM_DIR="/Users/Wes/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


alias minitest="bundle exec spring m"
