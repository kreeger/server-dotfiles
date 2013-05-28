require 'fileutils'
['pp','yaml'].each { |l| require l }

# Some helpful instance variables.
@home = File.expand_path "~"
@dotfiles_path = File.expand_path(File.dirname(__FILE__))
@paths = {
  vim: {
    bundle: File.join(@home, '.vim', 'bundle'),
    backup: File.join(@home, '.vim', 'backup'),
    scripts: File.join(@home, '.vim', 'scripts'),
    colors: File.join(@home, '.vim', 'colors'),
  },
}

@urls = {
  bashit: 'https://github.com/revans/bash-it',
  benlight: 'https://raw.github.com/gist/1481851',
}

# Directory setup declarations.

@paths.each { |top,hash| hash.each { |k,v| directory @paths[top][k] } }

task default: :all
task all: [:dotfiles, :vim, :fish]

# Base-level tasks.

desc 'Links all dotfiles into home directory.'
task :dotfiles do
  # Gets all dotfiles in this directory, for each...
  Dir['.*'].find_all{|f|File.file?(f)}.each do |f|
    # ...link_files them into home unless the links already exist.
    link_file File.expand_path(f), File.join(@home, f)
  end
end

# Vim tasks.

desc 'Run all vim tasks.'
task vim: 'vim:all'

namespace :vim do
  task all: [:vundle, :scripts, :colors]

  desc 'Sets up Vim.'
  task vundle: [:scripts, @paths[:vim][:bundle], @paths[:vim][:backup]] do
    puts "Installing Vundle."
    manage_git "git://github.com/gmarik/vundle.git",
               File.join(@paths[:vim][:bundle], 'vundle')
    system("vim +BundleInstall +qall > /dev/null 2&>1")
  end

  desc 'Installs all scripts from the vim directory.'
  task scripts: @paths[:vim][:scripts] do
    Dir.chdir File.join(@dotfiles_path,'vim')
    Dir['*.vim'].each do |f|
      puts "link_fileing custom Vim scripts."
      link_file File.expand_path(f), File.join(@paths[:vim][:scripts], f)
    end
  end

  desc 'Installs my color scheme(s).'
  task colors: @paths[:vim][:colors] do
    puts "Installing custom color scheme(s)."
    destination = File.join(@paths[:vim][:colors], 'benlight.vim')
    `curl -sko #{destination} #{@urls[:benlight]}`
  end
end

# Some utility functions.

def load_yaml(path, key=nil)
  yml = File.open(path, 'r') { |f| YAML::load f }
  key.nil? ? yml : yml[key.to_s]
end

def link_file(source, destination)
  # Delete the destination file if it exists, otherwise just link_file.
  if File.exists?(destination)
    File.directory?(destination) ? FileUtils.rm_r(destination) : File.delete(destination)
  end
  File.symlink(source, destination)
end

def manage_git(repo, destination)
  # First check if it exists. If it does, do a git pull. Else, clone.
  if File.exists? destination
    puts "Found existing repo at #{destination}. Updating it."
    Dir.chdir(destination)
    `git pull`
    Dir.chdir(File.join(destination, '..'))
  else
    puts "Repo #{repo} not found. Cloning to #{destination}."
    `git clone #{repo} "#{destination}"`
  end
end
