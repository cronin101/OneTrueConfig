alias ls='ls -a'
#alias vim='mvim -v'
alias story="~/dev/storyid.rb"
alias prod_sha="curl -I https://fac.freeagent.com/ 2>/dev/null | grep -E 'X-(Rev)' | cut -d ' ' -f2 | dos2unix"
alias prod_diff="git diff $(prod_sha) --patience"
alias mysqlram='diskutil erasevolume HFS+ "ramdisk" `hdiutil attach -nomount ram://1048576` && cp -R `brew --prefix`/var/mysql/* /Volumes/ramdisk/ && mysql.server start'
alias update_configs='(cd ~/dev/OneTrueConfig; sh update.sh)'
