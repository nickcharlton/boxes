module Boxes
  class Command
    # Command handling for the box building functionality.
    class Build < Command
      self.summary = 'Build boxes'
      self.description = 'Builds boxes using templates and scripts.'

      def self.options
        [
          ['--name', 'The name for the build'],
          ['--provider=[virtualbox|vmware]',
           'The provider to build the box for'],
          ['--template', 'Template to build the box with'],
          ['--scripts', 'Scripts to apply to the box']
        ].concat(super)
      end

      def initialize(argv)
        @build = {}
        @build[:name] = argv.option('name')
        @build[:provider] = argv.option('provider')
        @build[:template] = argv.option('template')
        scripts = argv.option('scripts') || ''
        @build[:scripts] = scripts.split(',')

        super
      end

      def validate!
        super

        %w(name provider template).each do |key|
          help! "A #{key} is required!" if @build[key.to_sym].nil?
        end
      end

      def run
        env = Boxes::Environment.new
        builder = Boxes::Builder.new(env, @build)
        builder.run
        builder.clean
      end
    end
  end
end
