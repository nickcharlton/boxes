require "boxes/testing/matchers/base_matcher"

module Boxes
  module Testing
    module Matchers
      class HaveExitStatusMatcher < BaseMatcher
        def failure_message
          "expected that `#{actual.cmd}` would exit with #{expected}"
        end

        private

        def match(actual, expected)
          expected == actual.exit_status
        end
      end
    end
  end
end
