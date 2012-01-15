require 'fileutils'
require 'vpm/version'
require 'vpm/manifest_parser'
require 'vpm/plugin'
require 'vpm/git_plugin'

module VPM
  def self.run(args)
    if args.empty?
      install_all_plugins
    end
  end

  def self.install_all_plugins
    vim_plugins_file = File.join(File.expand_path('.'), 'VimPlugins')
    content = File.read(vim_plugins_file)
    plugins = ManifestParser.parse(content)
    plugins.each(&:install)
  end

  def self.plugin_dir
    @dir_path ||= begin
                    dir_path = ENV['VPM_PLUGIN_DIR'] || File.join(ENV['HOME'], '.vim', 'bundle')
                    FileUtils.mkdir_p dir_path unless Dir.exists?(dir_path)
                    dir_path
                  end
  end
end
