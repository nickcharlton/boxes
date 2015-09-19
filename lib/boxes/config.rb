require 'pathname'
require 'yaml'

module Boxes
  # Stores the configuration for Boxes.
  class Config
    # The default settings for the configuration.
    DEFAULTS = {
      environment_vars: [
        { 'PACKER_CACHE_DIR' => (
            Pathname.new(ENV['BOXES_HOME_DIR'] || '~/.boxes'
                        ).expand_path + 'packer_cache') }
      ],
      template_paths: [
        # the gem install directory
        File.expand_path('../../../templates', __FILE__)
      ],
      script_paths: [
        # the gem install directory
        File.expand_path('../../../scripts', __FILE__)
      ]
    }

    # The directory which boxes works out of.
    def home_dir
      @home_dir ||= Pathname.new(
        ENV['BOXES_HOME_DIR'] || '~/.boxes').expand_path
    end

    # The directory inside the `home_dir` which boxes runs builds inside of.
    def working_dir
      @working_dir ||= Pathname.new(
        ENV['BOXES_WORKING_DIR'] || home_dir + 'tmp').expand_path
    end

    # Paths known to boxes for discovering templates.
    attr_accessor :template_paths

    # Paths known to boxes for discovering scripts.
    attr_accessor :script_paths

    # A Hash of environment variables Boxes sets in the run environment.
    attr_accessor :environment_vars

    def initialize
      configure_with(DEFAULTS)

      return unless user_settings_file.exist?

      user_settings = YAML.load_file(user_settings_file)
      configure_with(user_settings)
    end

    private

    def user_settings_file
      home_dir + 'config.yml'
    end

    def configure_with(opts = {}) # rubocop:disable Metrics/MethodLength
      opts.each do |k, v|
        next unless respond_to?("#{k}=")

        if v.class == Array
          v.each do |e|
            set = Set.new(send("#{k}".to_sym))
            set << e
            send("#{k}=".to_sym, set.to_a)
          end
        else
          send("#{k}=".to_sym, v)
        end
      end
    end
  end
end
