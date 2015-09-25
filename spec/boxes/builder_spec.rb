require 'spec_helper'

describe Boxes::Builder do
  let(:env) { Boxes::Environment.new }

  describe '#initialize' do
    it 'unpacks the arguments for the build' do
      build = Boxes::Builder.new(env, template: 'ubuntu/trusty64',
                                      scripts: ['ruby.sh'])

      expect(build.template.name).to eq 'ubuntu/trusty64'
      expect(build.scripts).to include('ruby.sh')
    end

    it 'throws an exception on unknown templates' do
      expect do
        Boxes::Builder.new(env, template: 'nope/nope')
      end.to raise_error(Boxes::Errors::TemplateNotFoundError)
    end

    it 'throws an exception on unknown scripts' do
      expect do
        Boxes::Builder.new(env, template: 'ubuntu/trusty64',
                                scripts: ['nope.sh'])
      end.to raise_error(Boxes::Errors::ScriptNotFoundError)
    end

    it 'throws an exception when missing a template' do
      expect do
        Boxes::Builder.new(env, script: 'nope.sh')
      end.to raise_error(Boxes::Errors::MissingArgumentError)
    end
  end
end
