git pull
git add -A
git commit -m "dev commit"
git push blog master

npm run docs:build
cd docs/.vuepress/dist

git init
git add -A
git commit -m "deploy with vuepress"

git push -f git@github.com:dewcked/blog.git master:gh-pages

cd C:\Users\USER-\Vue\VuePressBlog\docs