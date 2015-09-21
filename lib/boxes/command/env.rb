module Boxes
  class Command
    # Command handling for the environment used for building boxes.
    class Env < Command
      self.abstract_command = true
      self.default_subcommand = 'show'

      self.summary = 'Manage the build environment'
      self.description = 'Expore the environment that boxes uses for building '\
                         'inside of.'

      # Prints out the environment and configuration.
      class Show < Env
        self.summary = 'Show the environment and configuration'
        self.description = <<-DESC
            This lists the environment variables and other parts of the
            configuration that boxes uses to handle builds.
        DESC

        def run # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          puts 'Configuration:'.underline
          puts ''
          puts "HOME_DIR=\"#{Boxes.config.home_dir}\""
          puts "WORKING_DIR=\"#{Boxes.config.working_dir}\""
          puts "TEMPLATE_PATHS=\"#{Boxes.config.template_paths.join(', ')}\""
          puts "SCRIPT_PATHS=\"#{Boxes.config.script_paths.join(', ')}\""

          puts ''
          puts 'Environment Variables:'.underline
          puts ''
          Boxes.config.environment_vars.each do |e|
            puts "#{e.keys.join}=\"#{e.values.join}\""
          end
        end
      end
    end
  end
end
