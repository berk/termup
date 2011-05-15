require 'thor'

module Termup
  TERMUP_DIR = File.join(ENV['HOME'],'.config','termup')

  class Cli < Thor
    include Thor::Actions

    map "c" => :create
    map "e" => :edit
    map "l" => :list
    map "s" => :start

    desc "create PROJECT", "Create termup project (Shortcut: c)"
    def create(project)
      empty_directory TERMUP_DIR
      template "templates/template.yml", path(project)
    end

    desc "edit PROJECT", "Edit termup project (Shortcut: e)"
    def edit(project)
      say "please set $EDITOR in your .bash_profile." and return unless editor = ENV['EDITOR']
      system("#{editor} #{path(project)}")
    end
    
    desc "list", "List termup projects (Shortcut: l)"
    def list
      projects = Dir["#{TERMUP_DIR}/*.yml"].map{|file| File.basename(file,'.yml') }
      say "Your projects: #{projects.join(', ')}"
    end
    
    desc "start PROJECT", "Start termup project (Shortcut: s)"
    def start(project)
      Termup::Base.new(project)
    end
    
  protected
    def path(project)
      "#{TERMUP_DIR}/#{project}.yml"
    end
  end
end