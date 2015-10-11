module Boxes
  # Class which drives the build process.
  class Builder
    include Boxes::Errors

    attr_accessor :name, :template, :scripts, :provider

    # Initialise a new build.
    #
    # @param env [Boxes::Environment] environment to operate in.
    # @param args [Hash]
    # @param template [String] the name of the template.
    # @param scripts [Array] scripts to include in the build.
    def initialize(env, args) # rubocop:disable Metrics/MethodLength
      @name = args[:name] || fail(MissingArgumentError,
                                  'The name must be specified.')
      @provider = args[:provider] || fail(MissingArgumentError,
                                          'The provider must be specified.')
      template = args[:template] || fail(MissingArgumentError,
                                         'The template must be specified.')
      scripts = args.fetch(:scripts, [])

      @template = Template.new(env, template)
      @scripts = scripts.collect do |c|
        env.available_scripts.include?(c) ? c : fail(ScriptNotFoundError)
      end
    end

    # Run the build.
    def run # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      original_directory = FileUtils.pwd
      box_name = ''

      # render the template
      rendered_template = template.render(name: name,
                                          provider: provider,
                                          scripts: scripts)

      # write the template to a file
      File.open(Boxes.config.working_dir + "#{build_name}.json", 'w') do |f|
        f.puts rendered_template
      end

      # set the environment vars
      Boxes.config.environment_vars.each do |e|
        e.each do |k, v|
          ENV[k] = v.to_s
        end
      end

      # execute the packer command
      FileUtils.chdir(Boxes.config.working_dir)
      cmd = "packer build #{build_name}.json"
      status = Subprocess.run(cmd) do |stdout, stderr, _thread|
        puts stdout unless stdout.nil?
        puts stderr unless stderr.nil?

        # catch the name of the artifact
        if stdout =~ /\.box/
          box_name = stdout.gsub(/[a-zA-Z0-9:\-_]*?\.box/).first
        end
      end

      if status.exitstatus == 0
        FileUtils.mv(Boxes.config.working_dir + box_name,
                     "#{original_directory}/#{name}.box")
      else
        fail BuildRunError,
             'The build didn\'t complete successfully. Check the logs.'
      end
    end

    # Clean any temporary files used during building.
    def clean
      FileUtils.rm("#{build_name}.json")
    end

    private

    def build_name
      @build_name ||= "#{@name}-#{Time.now.strftime('%Y%m%d%H%M%S')}"
    end
  end
end
