function git_nuke --description="remove the file from all git history and push"
  git filter-branch --force --index-filter "git rm -rf --cached --ignore-unmatch $argv" --prune-empty --tag-name-filter cat -- --all && git push origin --force --all && git push origin --force --tags
end
