require 'fileutils'

require 'vpm/version'
require 'vpm/manifest_parser'
require 'vpm/plugin'
require 'vpm/git'

# options
require 'vpm/options'
require 'vpm/options/install'

# commands
require 'vpm/commands/install'

module VPM
  def self.run(args)
    command = args[0]
    plugin_name = args[1]

    if command.nil?
      install_all_plugins
    else
      run_command(command, plugin_name, args)
    end
  end

  def self.install_all_plugins
    vim_plugins_file = File.join(File.expand_path('.'), 'VimPlugins')
    content = File.read(vim_plugins_file)
    plugins = ManifestParser.parse(content)
    plugins.each(&:install)
  end

  def self.run_command(command, plugin_name, args)
    parser = Options.parser(command)
    options = parser.parse!(args)
    unless plugin_name
      puts parser.opts_parser
      exit
    end

    plugin = Plugin.new(plugin_name, options)
    plugin.run_command(command)
  end

  def self.plugin_dir
    @dir_path ||= begin
                    dir_path = ENV['VPM_PLUGIN_DIR'] ? File.expand_path(ENV['VPM_PLUGIN_DIR']) : File.join(ENV['HOME'], '.vim', 'bundle')
                    FileUtils.mkdir_p dir_path unless Dir.exists?(dir_path)
                    dir_path
                  end
  end
end
