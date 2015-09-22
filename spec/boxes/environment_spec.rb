require 'spec_helper'

describe Boxes::Environment do
  include FakeFS::SpecHelpers

  let(:env) { Boxes::Environment.new }

  before do
    current_directory = File.expand_path('../../..', __FILE__)

    FileUtils.mkdir_p(current_directory + '/templates')
    FileUtils.mkdir_p(current_directory + '/templates/ubuntu')
    FileUtils.touch(current_directory + '/templates/ubuntu/trusty64.erb')
    FileUtils.touch(current_directory + '/templates/ubuntu/preseed.cfg')

    FileUtils.mkdir_p(current_directory + '/scripts')
    FileUtils.touch(current_directory + '/scripts/postinstall.sh')
    FileUtils.touch(current_directory + '/scripts/purge.sh')
  end

  describe '#initialize' do
    it 'successfully builds up a working tree' do
      working_dir = Boxes.config.working_dir
      test_template = working_dir + 'templates/ubuntu/trusty64.erb'
      test_script = working_dir + 'scripts/postinstall.sh'

      env

      [working_dir,
       working_dir + 'templates',
       working_dir + 'scripts'].each do |e|
        expect(File.directory?(e)).to be_truthy
      end

      expect(File.exist?(test_template)).to be_truthy
      expect(File.exist?(test_script)).to be_truthy
    end
  end

  describe '#available_templates' do
    it 'lists available templates' do
      expect(env.available_templates).to be_a(Array)
      expect(env.available_templates).to include('ubuntu/trusty64')
    end

    it 'doesn\'t include hidden templates' do
      expect(env.available_templates).not_to include('ubuntu/preseed.cfg')
    end
  end

  describe '#hidden_templates' do
    it 'lists hidden templates' do
      expect(env.hidden_templates).to include('ubuntu/preseed.cfg')
    end
  end

  describe '#available_scripts' do
    it 'lists available scripts' do
      expect(env.available_scripts).to be_a(Array)
      expect(env.available_scripts).to include('postinstall.sh')
    end

    it 'doesn\'t include hidden scripts' do
      expect(env.available_scripts).not_to include('purge.sh')
    end
  end

  describe '#hidden_scripts' do
    it 'lists hidden scripts' do
      expect(env.hidden_scripts).to include('purge.sh')
    end
  end
end
