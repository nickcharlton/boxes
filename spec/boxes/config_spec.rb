require 'spec_helper'

describe Boxes::Config do
  let(:config) { Boxes::Config.new }

  context 'with no ENV modification' do
    it 'tries to load a user config file if one exists' do
      allow_any_instance_of(Pathname).to receive(:exist?).and_return(true)
      allow(YAML).to receive(:load_file).and_return({})

      config

      config_path = Pathname.new('~/.boxes/config.yml').expand_path
      expect(YAML).to have_received(:load_file).with(config_path)
    end

    it 'has a set of default config values' do
      expect(described_class::DEFAULTS).to be_a(Hash)
    end

    it 'has a home directory' do
      expect(config.home_dir).to eq Pathname.new('~/.boxes').expand_path
    end

    it 'has a working directory' do
      expect(config.working_dir).to eq Pathname.new('~/.boxes/tmp').expand_path
    end

    it 'has an array of template paths' do
      expect(config.template_paths).to be_a Array
    end

    it 'supports adding additional template paths' do
      allow_any_instance_of(Pathname).to receive(:exist?).and_return(true)
      allow(YAML).to receive(:load_file).and_return(
        template_paths: ['~/user_templates'])

      default_templates = Boxes::Config::DEFAULTS[:template_paths]

      expect(config.template_paths).to include('~/user_templates')
      expect(config.template_paths).to include(default_templates.first)
    end

    it 'does not duplicate template path values' do
      allow_any_instance_of(Pathname).to receive(:exist?).and_return(true)

      default_templates = Boxes::Config::DEFAULTS[:template_paths]

      allow(YAML).to receive(:load_file).and_return(
        template_paths: default_templates)

      expect(config.template_paths).to include(default_templates.first)
      expect(config.template_paths.count).to eq default_templates.count
    end

    it 'has an array of script paths' do
      expect(config.script_paths).to be_a Array
    end

    it 'supports adding additional script paths' do
      allow_any_instance_of(Pathname).to receive(:exist?).and_return(true)
      allow(YAML).to receive(:load_file).and_return(
        script_paths: ['~/user_scripts'])

      default_scripts = Boxes::Config::DEFAULTS[:script_paths]

      expect(config.script_paths).to include('~/user_scripts')
      expect(config.script_paths).to include(default_scripts.first)
    end

    it 'does not duplicate script path values' do
      allow_any_instance_of(Pathname).to receive(:exist?).and_return(true)

      default_scripts = Boxes::Config::DEFAULTS[:script_paths]

      allow(YAML).to receive(:load_file).and_return(
        script_paths: default_scripts)

      expect(config.script_paths).to include(default_scripts.first)
      expect(config.script_paths.count).to eq default_scripts.count
    end

    it 'has an array of environment variables' do
      expect(config.environment_vars).to be_a Array
    end

    it 'supports adding additional environment variables' do
      allow_any_instance_of(Pathname).to receive(:exist?).and_return(true)
      allow(YAML).to receive(:load_file).and_return(
        environment_vars: [{ 'CUSTOM_VAR' => 'TRUE' }])

      default_env_vars = Boxes::Config::DEFAULTS[:environment_vars]

      expect(config.environment_vars).to include('CUSTOM_VAR' => 'TRUE')
      expect(config.environment_vars).to include(default_env_vars.first)
    end

    it 'does not duplicate environment variable values' do
      allow_any_instance_of(Pathname).to receive(:exist?).and_return(true)

      default_env_vars = Boxes::Config::DEFAULTS[:environment_vars]

      allow(YAML).to receive(:load_file).and_return(
        environment_vars: default_env_vars)

      expect(config.environment_vars).to include(default_env_vars.first)
      expect(config.environment_vars.count).to eq default_env_vars.count
    end
  end

  context 'with ENV modification' do
    it 'tries to load a different user config file' do
      allow_any_instance_of(Pathname).to receive(:exist?).and_return(true)
      allow(YAML).to receive(:load_file).and_return({})

      ENV['BOXES_HOME_DIR'] = '/something'

      config

      config_path = Pathname.new('/something/config.yml').expand_path
      expect(YAML).to have_received(:load_file).with(config_path)

      ENV.delete 'BOXES_HOME_DIR'
    end

    it 'can change the home directory' do
      ENV['BOXES_HOME_DIR'] = '/something'

      expect(config.home_dir).to eq Pathname.new('/something')

      ENV.delete 'BOXES_HOME_DIR'
    end

    it 'can change the working directory' do
      ENV['BOXES_WORKING_DIR'] = '/something'

      expect(config.working_dir).to eq Pathname.new('/something')

      ENV.delete 'BOXES_WORKING_DIR'
    end
  end
end
