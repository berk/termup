#!/usr/bin/env ruby

require('./lib/termup/version.rb')

system("gem build termup.gemspec")
system("gem install termup-#{Termup::VERSION}.gem")