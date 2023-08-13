git checkout --orphan tmp
git add -A
git commit -m "clean all commits, then build a new branch"
git branch -D master
git branch -m master
git push -f origin master
