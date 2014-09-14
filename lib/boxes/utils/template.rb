require 'erb'

module Boxes
  module Utils
    # Utility class for rendering ERB templates without polluting
    # the current context.
    module Template
      # Render a template string with a set of values.
      #
      # @param template [String] the erb template to render.
      # @param hash [Hash] the values to substitute
      #
      # @return [String] the rendered template.
      def self.render(template, hash)
        ERB.new(template, nil, '-').result(ERBContext.new(hash).get_binding)
      end

      # This holds the rendering context, with no other values to pollute
      # across.
      class ERBContext
        # Create a new context with a given hash of values.
        #
        # @param hash [Hash] the values to substitude.
        def initialize(hash)
          hash.each_pair do |key, value|
            instance_variable_set('@' + key.to_s, value)
          end
        end

        # The binding which is passed to ERB.
        def get_binding
          binding
        end
      end
    end
  end
end
