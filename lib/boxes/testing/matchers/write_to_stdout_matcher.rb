require "boxes/testing/matchers/base_matcher"

module Boxes
  module Testing
    module Matchers
      class WriteToStdoutMatcher < BaseMatcher
        def failure_message
          "expected that '#{clean(actual.stdout)}' would be #{clean(expected)}"
        end

        private

        def match(actual, expected)
          expected == actual.stdout
        end

        def clean(output)
          output.gsub(/\n/, '\n')
        end
      end
    end
  end
end
