module Boxes
  # Representations of Packer templates.
  class Template
    include Boxes::Errors

    attr_reader :template

    # Load a template with a given name.
    #
    # @param env [Boxes::Environment] the environment to source templates.
    # @param name [String] the name of the template.
    #
    # @return [Boxes::Template] a template instance.
    def initialize(env, name)
      fail(TemplateNotFoundError) unless env.available_templates.include?(name)

      @template = ''
      File.open(Boxes.config.working_dir + "templates/#{name}.erb") do |f|
        @template << f.read
      end
    end

    # Render the template.
    #
    # @param args [Hash] the values to set.
    #
    # @return [String] the rendered template.
    def render(args)
      ERB.new(template, nil, '-').result(ERBContext.new(args).get_binding)
    end

    # A context to render inside, to avoid polluting other classes.
    class ERBContext
      # Create a new context with a given hash of values.
      #
      # @params args [Hash] the values to substitute.
      def initialize(args = {})
        args.each_pair do |k, v|
          instance_variable_set('@' + k.to_s, v)
        end
      end

      # The binding which is passed to ERB.
      def get_binding # rubocop:disable Style/AccessorMethodName
        binding
      end
    end
  end
end
