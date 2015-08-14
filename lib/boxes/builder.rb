require 'fileutils'

module Boxes
  # Class which drives the build process.
  class Builder
    attr_accessor :name, :target, :type

    # Initialise a new boxes build.
    #
    # @param name [String] the name of the box.
    # @param type [String] the type of box to build.
    # @param target [String] the target (e.g.: vmware) to build against.
    def initialize(name, type, target)
      @name = name
      @type = type
      @target = target
    end

    # Build the given template.
    #
    # @param template [String] the template to build the box with.
    # @param output_file [String] the filename to output as.
    # @return [Boolean] the status of the build process.
    # rubocop:disable Metrics/MethodLength
    def build(template,
              output_name = "packer_#{@name}-#{@type}_#{@target}.box")
      # rubocop:enable Metrics/MethodLength
      name = "#{@name}-#{@type}-#{@target}"

      @builder = # should be a getter
        if target == 'virtualbox'
          'virtualbox-iso'
        elsif target == 'vmware'
          'vmware-iso'
        else
          target
        end

      # render the ERB template (in it's own context)
      hash =  { name: @name, type: @type, builder: @builder }
      packer_template = Boxes::Utils::Template.render(template, hash)

      # ensure tmp/ exists
      FileUtils.mkdir_p('tmp')

      # write the template to tmp
      File.open("tmp/#{name}.json", 'w') do |f|
        f.puts packer_template
      end

      # run packer
      result = system "packer build tmp/#{name}.json"

      FileUtils.mv(output_name, "#{name}.box") if result

      result
    end

    # Clean any temporary files used during building.
    def clean
      FileUtils.rm("tmp/#{@name}-#{@type}-#{@target}.json")
    end
  end
end
