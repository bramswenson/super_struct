require 'guard/rspec/dsl'
dsl   = Guard::RSpec::Dsl.new(self)
rspec = dsl.rspec
ruby  = dsl.ruby

guard :rspec, cmd: 'bundle exec rspec', spec_paths: %w( spec ) do
  watch(%r{^lib/(.+)\.rb$}) { |m| "#{rspec.spec_dir}/#{m[1]}_spec.rb" }
  watch(%r{^spec/.+\.rb$})
end
