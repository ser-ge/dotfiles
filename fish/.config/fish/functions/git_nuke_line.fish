set -l proceed (read -p "This will remove the lines from all git history and push changes. Are you sure you want to continue? [y/N] ")
switch $proceed
    case 'Y' 'y'
git filter-branch --tree-filter 'sed -i "/sensitive information/ d" filename' -- --all
    case '*'
        echo "Operation cancelled."
        return 1
end

