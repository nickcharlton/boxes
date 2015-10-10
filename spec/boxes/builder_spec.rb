require 'spec_helper'

describe Boxes::Builder do
  let(:env) { Boxes::Environment.new }

  describe '#initialize' do
    it 'unpacks the arguments for the build' do
      build = Boxes::Builder.new(env, name: 'build-name',
                                      provider: 'vmware',
                                      template: 'ubuntu/trusty64',
                                      scripts: ['ruby.sh'])

      expect(build.template.name).to eq 'ubuntu/trusty64'
      expect(build.scripts).to include('ruby.sh')
    end

    it 'requires a name' do
      expect do
        Boxes::Builder.new(env, provider: 'vmware', template: 'ubuntu/trusty64')
      end.to raise_error(Boxes::Errors::MissingArgumentError)
    end

    it 'requires a provider' do
      expect do
        Boxes::Builder.new(env, name: 'build-name', template: 'ubuntu/trusty64')
      end.to raise_error(Boxes::Errors::MissingArgumentError)
    end

    it 'requires a template' do
      expect do
        Boxes::Builder.new(env, name: 'build-name', provider: 'vmware')
      end.to raise_error(Boxes::Errors::MissingArgumentError)
    end

    it 'throws an exception on unknown templates' do
      expect do
        Boxes::Builder.new(env, name: 'build-name',
                                provider: 'vmware',
                                template: 'nope/nope')
      end.to raise_error(Boxes::Errors::TemplateNotFoundError)
    end

    it 'throws an exception on unknown scripts' do
      expect do
        Boxes::Builder.new(env, name: 'build-name',
                                provider: 'vmware',
                                template: 'ubuntu/trusty64',
                                scripts: ['nope.sh'])
      end.to raise_error(Boxes::Errors::ScriptNotFoundError)
    end
  end
end
