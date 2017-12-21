module Boxes
  module Testing
    module Matchers
      class BaseMatcher
        attr_reader :actual, :expected

        # we can't compare to nil, because we might want nil
        UNDEFINED = Object.new.freeze

        def initialize(expected = UNDEFINED)
          @expected = expected unless UNDEFINED.equal?(expected)
        end

        def matches?(actual)
          @actual = actual
          match(actual, expected)
        end
      end
    end
  end
end
