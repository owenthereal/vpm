module Commands::InstallAllPlugins
  def self.call(args)
    vim_plugins_file = File.join(File.expand_path('.'), 'VimPlugins')
    content          = File.read(vim_plugins_file)
    plugins          = VPM::ManifestParser.parse(content)
    plugins.each(&:install)
  end
end
