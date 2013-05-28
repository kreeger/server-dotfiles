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

desc 'Run all sublime 2 tasks.'
task sublime2: 'sublime2:all'

namespace :sublime2 do
  task all: [:plugins, :settings]

  # This is nearly identical to my Vim plugin installer; maybe abstract?
  desc 'Install non-PackageManager plugins for sublime 2.'
  task plugins: @paths[:sublime2][:osx] do
    puts "Cloning extra plugins for Sublime Text 2."
    plugins = load_yaml(File.join(@dotfiles_path, 'sublime.yml'), :plugins)
    Dir.chdir(@paths[:sublime2][:osx])
    plugins.each do |author, repos|
      Array(repos).each do |repo|
        manage_git "https://github.com/#{author}/#{repo[0]}",
                   File.join(@paths[:sublime2][:osx], repo[1])
      end
    end
  end

  desc 'Symlink sublime 2 settings.'
  task settings: File.join(@paths[:sublime2][:osx], 'User') do
    puts "Symlinking sublime 2 settings files."
    Dir.chdir File.join(@dotfiles_path, 'sublime')
    Dir['*.sublime-settings','*.sublime-keymap','*.sublime-mousemap','*.sublime-build','*.py'].each do |f|
      link_file File.expand_path(f),
                File.join(@paths[:sublime2][:osx], 'User', f)
    end
  end
end

desc 'Run all sublime 3 tasks.'
task sublime3: 'sublime3:all'

namespace :sublime3 do
  task all: [:plugins, :settings]

  # This is nearly identical to my Vim plugin installer; maybe abstract?
  desc 'Install non-PackageManager plugins for sublime 3.'
  task plugins: @paths[:sublime3][:osx] do
    puts "Cloning extra plugins for Sublime Text 3."
    plugins = load_yaml(File.join(@dotfiles_path, 'sublime.yml'), :plugins)
    Dir.chdir(@paths[:sublime3][:osx])
    plugins.each do |author, repos|
      Array(repos).each do |repo|
        manage_git "https://github.com/#{author}/#{repo[0]}",
                   File.join(@paths[:sublime3][:osx], repo[1])
      end
    end
  end

  desc 'Symlink sublime 3 settings.'
  task settings: File.join(@paths[:sublime3][:osx], 'User') do
    puts "Symlinking sublime 3 settings files."
    Dir.chdir File.join(@dotfiles_path, 'sublime')
    Dir['*.sublime-settings','*.sublime-keymap','*.sublime-mousemap','*.sublime-build','*.py'].each do |f|
      link_file File.expand_path(f),
                File.join(@paths[:sublime3][:osx], 'User', f)
    end
  end
end

# Zsh tasks.

desc 'Run all zsh tasks.'
task zsh: 'zsh:all'

namespace :zsh do
  task all: [:ohmyzsh, :scripts, :themes]

  desc 'Install ohmyzsh.'
  task :ohmyzsh do
    puts "Cloning oh-my-zsh."
    manage_git @urls[:ohmyzsh], File.join(@home, '.oh-my-zsh')
  end

  desc 'Install custom zsh scripts.'
  task scripts: @paths[:zsh][:scripts] do
    puts "Symlinking in custom zsh scripts."
    Dir.chdir File.join(@dotfiles_path,'zsh')
    Dir['*'].reject { |e| e.match /^\./ }.each do |f|
      link_file File.expand_path(f), File.join(@paths[:zsh][:scripts], f)
    end
  end

  desc 'Install custom zsh themes.'
  task themes: @paths[:zsh][:themes] do
    puts "Symlinking in custom zsh themes."
    Dir.chdir File.join(@dotfiles_path, 'zsh-themes')
    Dir['*'].reject { |e| e.match /^\./ }.each do |f|
      link_file File.expand_path(f), File.join(@paths[:zsh][:themes], f)
    end
  end
end

# Zsh tasks.

desc 'Run all fish tasks.'
task fish: 'fish:all'

namespace :fish do
  task all: [:scripts]

  desc 'Install custom fish scripts.'
  task scripts: @paths[:fish][:base] do
    puts "Symlinking in custom fish scripts."
    Dir.chdir File.join(@dotfiles_path,'fish')
    Dir['*'].reject { |e| e.match /^\./ }.each do |f|
      link_file File.expand_path(f), File.join(@paths[:fish][:base], f)
    end
  end
end

# RBENV tasks.

desc 'Run all RBENV tasks.'
task rbenv: 'rbenv:all'

namespace :rbenv do
  task all: [:install, :plugins]

  desc 'Install rbenv.'
  task :install do
    puts "Installing rbenv."
    Dir.chdir(@home)
    manage_git @urls[:rbenv][:rbenv], File.join(@home, '.rbenv')
  end

  desc 'Install rbenv plugins.'
  task :plugins do
    puts "Cloning ruby-build."
    manage_git @urls[:rbenv][:rubybuild], File.join(@home, 'ruby-build')
    puts "Installing ruby-build."
    Dir.chdir(File.join(@home, 'ruby-build'))
    `sh install.sh`
    Dir.chdir(@home)
    puts "Removing temporary ruby-build directory."
    FileUtils.rm_rf 'ruby-build'
  end
end

desc 'Symlinks Dropbox to various places.'
task dropbox: 'dropbox:all'

namespace :dropbox do
  task all: [:minecraft]

  desc 'Symlink texture packs.'
  task :minecraft do
    puts "Symlinking minecraft texture packs."
    destination = File.join(@home, 'Library', 'Application Support', 'minecraft', 'texturepacks')
    debugger
    link_file @paths[:dropbox][:minecraft], destination
  end

  desc 'Symlink MultiMC instance directory.'
  task :multimc do
    puts "Symlinking minecraft instances."
    base = File.join('/Applications', 'MultiMC.app', 'Contents', 'Resources')
    %w(Instances Mods lwjgl).each do |dir|
      link_file File.join(@paths[:dropbox][:multimc], dir), File.join(base, dir.downcase)
    end
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
