require 'fileutils'

# core
require 'vpm/core'
require 'vpm/core/plugin'
require 'vpm/core/plugins'
require 'vpm/core/manifest_parser'

# options
require 'vpm/command_options/abstract_command_options'
require 'vpm/command_options'

# commands
require 'vpm/commands'

require 'vpm/runner'
require 'vpm/utils/git'
require 'vpm/version'

module VPM
  def self.run(args)
    command = args.shift
    options = VPM::CommandOptions[command].parse!(args)
    VPM::Commands[command].call options
  end

  def self.plugins
    @plugins ||= Core::Plugins.load_from_file(plugins_file)
  end

  def self.vim_dir_path
    @vim_dir_path ||= begin
                        dir_path = ENV['VPM_VIM_DIR'] ? File.expand_path(ENV['VPM_VIM_DIR']) : File.join(ENV['HOME'], '.vim')
                        FileUtils.mkdir_p dir_path unless Dir.exists?(dir_path)
                        dir_path
                      end
  end

  def self.bundle_dir_path
    @bundle_dir_path ||= begin
                           dir_path = File.join(vim_dir_path, 'bundle')
                           FileUtils.mkdir_p dir_path unless Dir.exists?(dir_path)
                           dir_path
                         end
  end

  def self.plugins_file
    @insatlled_plugins_file ||= begin
                                  vpm_dir_path = File.join(vim_dir, 'vpm')
                                  FileUtils.mkdir_p vpm_dir_path unless Dir.exists?(vpm_dir_path)

                                  plugins_file_path = File.join(vpm_dir_path, 'plugins.yaml')
                                  FileUtils.touch(plugins_file_path)
                                  plugins_file_path
                                end
  end

  def self.vpmrc_path
    File.expand_path File.join(ENV['HOME'], '.vpmrc')
  end

  def self.vimrc_path
    File.expand_path File.join("~", ".vimrc")
  end
end
