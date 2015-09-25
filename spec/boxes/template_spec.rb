require 'spec_helper'

describe Boxes::Template do
  include FakeFS::SpecHelpers

  let(:env) { Boxes::Environment.new }

  before do
    current_directory = File.expand_path('../../..', __FILE__)

    FileUtils.mkdir_p(current_directory + '/templates')
    FileUtils.mkdir_p(current_directory + '/templates/ubuntu')

    mock_template = <<-EOF
    <% @scripts.each do |s| %>
    <%= s %>
    <% end %>
    EOF

    File.open(current_directory + '/templates/ubuntu/trusty64.erb', 'w') do |f|
      f.puts mock_template
    end
  end

  describe '#initialize' do
    it 'can read in a known template' do
      template = described_class.new(env, 'ubuntu/trusty64')

      expect(template.template).to be_a(String)
    end

    it 'throws an exception if the template is missing' do
      expect do
        described_class.new(env, 'nope/nope')
      end.to raise_error(Boxes::Errors::TemplateNotFoundError)
    end
  end

  describe '#render' do
    it 'renders a template with a set of variables' do
      template = described_class.new(env, 'ubuntu/trusty64')
      rendered = template.render(scripts: ['ruby.sh'])

      expect(rendered).to include('ruby.sh')
    end
  end
end
