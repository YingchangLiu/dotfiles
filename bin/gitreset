git checkout --orphan tmp
git add -A
git commit -m "New root commit"
git branch -D master
git branch -m master
git push -f origin master
git gc --aggressive --prune=now