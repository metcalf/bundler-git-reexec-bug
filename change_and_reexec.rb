#!/usr/bin/env ruby

require 'bundler/setup'

sha = nil
Dir.chdir("somegem") do
  if !system('git commit --allow-empty --message "bump sha"')
    raise "Commit failed!"
  end
  sha = `git rev-parse HEAD`
end
puts "Updating sha to #{sha}"
File.write('ref', sha)

# This fixes things
# ENV.delete('RUBYOPT')

exec(['./bundle_and_run.sh', './bundle_and_run.sh'])
