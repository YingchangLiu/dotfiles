## github flow

### 1. Fork the repository
go to the repository you want to contribute to and click the fork button, this will create a copy of the repository in your github account

### 2. Clone the repository
clone the repository from your github account to your local machine
``` bash 
git clone [url]
```

### 3. Add the original repository as a remote
add the original repository as a remote to your local repository
``` bash
git remote add upstream [url]
```

### 4. Create a branch
create a branch for your changes
``` bash
git switch -c [branch name] 
```

### 5. Make your changes
make your changes to the code

### 6. Check your changes
check your changes with
``` bash
git status 
```

### 7. Add your changes
add your changes to the staging area
``` bash
git add [file name]
```

### 8. Commit your changes
commit your changes
``` bash
git commit -m "[commit message]"
```

### 9. Push your changes
push your changes to your forked repository
``` bash
git push origin [branch name]
```

### 10. If the branch is behind the original repository
if the branch is behind the original repository, pull the changes from the original repository to the master branch
``` bash
git pull upstream master
```

### 11. rebase your branch
rebase your branch to the master branch
``` bash
git rebase master
```

### 12. If there are conflicts
if there are conflicts, resolve them and add the resolved files to the staging area
``` bash
git add [file name]
```

### 13. Continue the rebase
continue the rebase
``` bash
git rebase --continue
```

### 14. Push your changes
push your changes to your forked repository
``` bash
git push origin [branch name]
```

### 15. Create a pull request
create a pull request from your forked repository to the original repository

### 16. Wait for the pull request to be reviewed
wait for the pull request to be reviewed and merged

### 17. Delete your branch
delete your branch
``` bash
git branch -d [branch name]
```

### 18. Pull the changes from the original repository
pull the changes from the original repository to your local repository
``` bash
git pull upstream master
```

