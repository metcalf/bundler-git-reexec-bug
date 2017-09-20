#! /usr/bin/env bash -euxo pipefail

bundle check || bundle install
echo "exec in 1s"
sleep 1
exec ./change_and_reexec.rb
