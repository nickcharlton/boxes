module Boxes
  module Testing
    module Command
      attr_reader :response

      def run_command(cmd)
        stdout = `#{cmd}`

        @response = Response.new(cmd, stdout, $?.exitstatus)
      end

      class Response
        attr_accessor :cmd, :stdout, :exit_status

        def initialize(cmd, stdout, exit_status)
          @cmd = cmd
          @stdout = stdout
          @exit_status = exit_status
        end
      end
    end
  end
end
