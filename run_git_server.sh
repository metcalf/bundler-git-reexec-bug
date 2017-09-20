#! /usr/bin/env bash -euxo pipefail

pushd somegem
rm -rf .git
git init
git add .
git commit -am "initial commit"
git rev-parse HEAD > ../ref
popd

trap "rm -rf somegem/.git" EXIT

git daemon --verbose --export-all --base-path=somegem/.git --reuseaddr --strict-paths somegem/.git/
