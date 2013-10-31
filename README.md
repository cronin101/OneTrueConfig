#OneTrueConfig
###Managing configuration. Easy. In the cloud.

![VIM, it's what's for dinner.](http://i.imgur.com/A6vKlmK.png)

##Installation Instructions
`curl -s 'https://gist.github.com/cronin101/a7acffa01dc6171fdcc7/raw/3d480561187cbc26ee3550a015567d6f1f1f4b18/OneTrueConfig.sh' | sh`

* Wipe away machine-specific configuration for shared applications.
* Clone from the *One True Configuration* repo.
* Local changes to the configuration repo can be propogated to other devices by git push/pull.


| Application |  |
-------|---
| Tmux | `.tmux.conf` |
| Vim | `autoload`, `bundle`, `snippets` and `.vimrc`. |
| Xmonad | `xmonad.hs` and `.xmobarrc`. |
| Zsh | `.zshrc` |
| GHCI | `.ghci` (including `lambdabot` plugin)|
| Chruby/RBENV | `.ruby-version` |
| Pry | `.pryrc` |
