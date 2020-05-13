# 在用这个脚本前，需要做一些准备工作
# git worktree add -B gh-pages public origin/gh-pages
# git checkout master
# rm -rf public
# echo "public" >> .gitignore
# git checkout --orphan gh-pages
# git reset --hard
# git commit --allow-empty -m "Initializing gh-pages branch"
# git push origin gh-pages



#!/bin/sh

if [ "`git status -s`" ]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo "Deleting old publication"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages public upstream/gh-pages

echo "Removing existing files"
rm -rf public/*

echo "Generating site"
hugo

echo "Updating gh-pages branch"
cd public && git add --all && git commit -m "Publishing to gh-pages (publish.sh)"

#echo "Pushing to github"
git push --all
