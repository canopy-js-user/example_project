#!/bin/bash
set -x
set -o errexit -o nounset

if [ "$TRAVIS_BRANCH" != "master" ]
then
  echo "This commit was made against the $TRAVIS_BRANCH and not the master!"
  exit 0
fi

rev=$(git rev-parse --short HEAD)

cd build

git init
git config user.name "YOUR NAME"
git config user.email "YOUR EMAIL"

git remote add upstream "https://$GH_TOKEN@github.com/USER_OR_ORG_NAME/USER_OR_ORG_NAME.github.io.git"
git fetch upstream
git reset upstream/master # Or github-pages

touch .nojekyll
touch .

git add -A .
git commit -m "rebuild pages at ${rev}"
git push -q upstream HEAD:master # Or github-pages
