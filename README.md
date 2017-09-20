This repo contains scripts to reproduce https://github.com/bundler/bundler/issues/6049. The
bug is:
* Start a Ruby process that calls `Bundler.setup`.
* Update a git reference in the Gemfile to a value that isn't yet checked out.
* Exec a process from the original Ruby process that calls `bundle install`.
* It fails because the `RUBYOPT='-rbundler/setup'` environment variable causes
  a failure in `Bundler.setup` before the install can run. 

I believe this behavior is specific to git sources since they validate the repo when just loading at:
https://github.com/bundler/bundler/blob/v1.15.4/lib/bundler/source/git.rb#L200-L205

To reproduce:
* Run `./run_git_server.sh`
* Separately run `./bundle_and_run.sh`
* Observe failure after re-exec
* Uncomment `ENV.delete('RUBYOPT')` in `change_and_reexec.rb` and repeat these steps... no failure!
