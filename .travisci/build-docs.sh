#!/bin/bash

set -xe

sudo apt-get update
sudo apt-get install -y python3-pip
sudo pip3 install sphinx==1.8.5
cd docs
make html

cd build
git clone --depth 1 https://github.com/$TRAVIS_REPO_SLUG -b gh-pages ghostferry-pages
cp -ar html/. ghostferry-pages/$TRAVIS_BRANCH
cd ghostferry-pages

echo "<html>" > index.html
echo "  <head>" >> index.html
echo "    <title>Ghostferry Documentations</title>" >> index.html
echo "  </head>" >> index.html
echo "  <body>" >> index.html
echo "    <h3>Ghostferry Documentation Version Selector</h3>" >> index.html
echo "    <ul>" >> index.html
for d in */; do
echo "      <li><a href=\"${d}index.html\">${d}</a></li>" >> index.html
done
echo "    </ul>" >> index.html
echo "  </body>" >> index.html
echo "</html>" >> index.html

rm -rf .git
