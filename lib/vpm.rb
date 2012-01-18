require 'fileutils'
require 'tmpdir'
require 'transaction'
require 'vpm/version'
require 'vpm/manifest_parser'
require 'vpm/plugin'
require 'vpm/git_plugin'
require 'vpm/commands'
require 'vpm/tasks'

module VPM
  def self.run(args)
    command = args.shift.to_s.capitalize
    Commands[command].call args
  end

  def self.bundle_dir_path
    File.join(vim_dir_path, 'bundle')
  end

  def self.vim_dir_path
    ENV['VPM_VIM_DIR'] || File.expand_path(File.join(ENV['HOME'], '.vim'))
  end

  def self.vpmrc_path
    File.expand_path File.join(ENV['HOME'], '.vpmrc')
  end

  def self.vimrc_path
    File.expand_path File.join("~", ".vimrc")
  end
end
