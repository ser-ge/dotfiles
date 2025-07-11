set -l proceed (read -p "This will remove the file from all git history and push changes. Are you sure you want to continue? [y/N] ")
switch $proceed
    case 'Y' 'y'
  git filter-branch --force --index-filter "git rm -rf --cached --ignore-unmatch $argv" --prune-empty --tag-name-filter cat -- --all && git push origin --force --all && git push origin --force --tags
    case '*'
        echo "Operation cancelled."
        return 1
end

