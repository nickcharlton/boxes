module Boxes
  # Standardise handling the stdout and stderr from Open3.
  #
  # @example Print the values returned to stdout and stderr
  #   Boxes::Utils::Subprocess.run 'ls' do |stdout, stderr, thread|
  #     puts stdout unless stdout == nil
  #     puts stderr unless stderr == nil
  #   end
  #
  class Subprocess
    # Create a new subprocess with a command, with a block for the response.
    #
    # @param cmd [String] the command to run
    # @yield [stdout, stderr, thread] Gives the stdout, stderr and process
    #   thread to the block.
    def self.run(command) # rubocop:disable Metrics/MethodLength
      # see: http://stackoverflow.com/a/1162850/83386
      Open3.popen3(command) do |_stdin, stdout, stderr, thread|
        # read each stream from a new thread
        { out: stdout, err: stderr }.each do |key, stream|
          stream.each_line do |line|
            if key == :out
              yield line, nil, thread if block_given?
            elsif key == :err
              yield nil, line, thread if block_given?
            end
          end
        end

        thread.join # don't exit until the external process is done

        thread.value
      end
    end
  end
end
