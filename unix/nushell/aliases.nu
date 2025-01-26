# File Tree
alias ll = eza -l -g --icons --git
alias llt = eza -1 --icons --tree --git-ignore
alias lsa = ls -lah
alias l = eza
alias la = eza -lh --all

# Core
alias grep = grep --color=auto
alias cl = clear

# Vim
alias v = nvim

# Weather
def wtr [] {
  wget -qO- https://wttr.in/ | ghead -n -1
}

def wtr2 [] {
  wget -qO- https://v2.wttr.in/ | ghead -n -1
}

# Github Copilot
alias ghc = gh copilot
alias "?git" = gh copilot suggest -t git
alias "??" = gh copilot suggest -t shell
alias "?e" = gh copilot explain

# Bun
alias br = bun run
alias bi = bun install

# Aerospace
def ff [] {
  aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}

# Git
alias ga = git add
alias gaa = git add --all

alias gb = git branch
alias gba = git branch --all
alias gbd = git branch --delete
alias gbD = git branch --delete --force

alias gc = git commit --verbose
alias gc! = git commit --verbose --amend
alias gcn! = git commit --verbose --no-edit --amend
alias gcam = git commit --all --message

alias gcf = git config --list
alias ghh = git help

alias gcm = git checkout (git_main_branch)
alias gcd = git checkout (git_develop_branch)
alias gco = git checkout
alias gcb = git checkout -b
alias gcp = git cherry-pick

alias gf = git fetch
alias gfa = git fetch --all --prune --jobs=10
alias gfo = git fetch origin

alias gp = git push
alias gpsup = git push --set-upstream origin (git_current_branch)

alias gl = git pull
alias glg = git log --stat

alias gm = git merge
alias grb = git rebase

alias gss = git status --short
alias gst = git status

alias gsta = git stash push

alias gstaa = git stash apply
alias gstl = git stash list
alias gstd = git stash drop

def gpa [path] {
  gaa
  gcam $path
  gp
}

def gpasup [path] {
  gaa
  gcam $path
  gpsup
}

def gpe [] {
  gaa
  gitmoji -c
  gp
}

def gpesup [] {
  gaa
  gitmoji -c
  gpsup
}

# -----------------------------------------
# git_main_branch
# -----------------------------------------
def git_main_branch [] {
    # Check if we're in a Git repository
    let check_git_dir = (try { git rev-parse --git-dir } catch { null })
    if $check_git_dir == null {
        # Not a git repo, just return quietly
        return
    }

    # List of possible main-like references (local and remote)
    let references = [
        "refs/heads/main"
        "refs/remotes/origin/main"
        "refs/remotes/upstream/main"
        "refs/heads/trunk"
        "refs/remotes/origin/trunk"
        "refs/remotes/upstream/trunk"
        "refs/heads/mainline"
        "refs/remotes/origin/mainline"
        "refs/remotes/upstream/mainline"
        "refs/heads/default"
        "refs/remotes/origin/default"
        "refs/remotes/upstream/default"
    ]

    for $ref in $references {
        # If git show-ref --verify succeeds, we have our branch
        let check_ref = (try { git show-ref -q --verify $ref } catch { null })
        if $check_ref != null {
            # Print the basename of the ref (e.g. "main" from "refs/heads/main")
            let branch_name = ($ref | path basename)
            echo $branch_name
            return
        }
    }

    # If nothing matched, default to "master"
    echo "master"
}

# -----------------------------------------
# git_develop_branch
# -----------------------------------------
def git_develop_branch [] {
    # Check if we're in a Git repository
    let check_git_dir = (try { git rev-parse --git-dir } catch { null })
    if $check_git_dir == null {
        return
    }

    # Possible develop-like branch names
    let possible_devs = [
        "dev"
        "devel"
        "development"
    ]

    for $branch in $possible_devs {
        let check_branch = (try { git show-ref -q --verify ( $"refs/heads/" + $branch ) } catch { null })
        if $check_branch != null {
            echo $branch
            return
        }
    }

    # If none matched, default to "develop"
    echo "develop"
}

# -----------------------------------------
# git_current_branch
# -----------------------------------------
def git_current_branch [] {
    # Try symbolic-ref first
    let symbolic_ref = (try { git symbolic-ref --quiet HEAD } catch { null })

    if $symbolic_ref == null {
        # If symbolic-ref failed, see if we can do rev-parse (detached HEAD case)
        let rev_parse_ref = (try { git rev-parse --short HEAD } catch { null })
        if $rev_parse_ref == null {
            # No Git repo or no commit exists
            return
        } else {
            # We’re in a detached HEAD state, show short commit hash
            echo $rev_parse_ref
            return
        }
    }

    # If symbolic-ref worked, strip "refs/heads/" to get the branch name
    let current_branch = ($symbolic_ref | str replace "refs/heads/" "")
    echo $current_branch
}

