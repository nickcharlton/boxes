module Boxes
  module Testing
    module Matchers
      require "boxes/testing/matchers/have_exit_status_matcher"
      require "boxes/testing/matchers/write_to_stdout_matcher"

      def have_exit_status(status)
        HaveExitStatusMatcher.new(status)
      end

      def write_to_stdout(data)
        WriteToStdoutMatcher.new(data)
      end
    end
  end
end
