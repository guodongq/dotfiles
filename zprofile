# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

export GOROOT=/opt/homebrew/Cellar/go/1.21.3/libexec
export GOPATH=/Users/guodongq/Projects
export PATH=$GOPATH/bin:$PATH
export PATH=/Users/guodongq/.local/bin:$PATH

export LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export PATH=/opt/homebrew/opt/llvm/bin:$PATH
export PATH="$PATH:/Users/guodongq/Applications/istio-1.19.1/bin"
alias k=kubectl

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
