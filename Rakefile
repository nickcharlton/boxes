# encoding: UTF-8

require 'fileutils'
require_relative 'lib/boxes'

@distros = %w{debian ubuntu}
@targets = %w{virtualbox vmware}
@standard_types = %w{standard chef puppet}
@special_types = [{name: 'ruby-box', template: 'ubuntu/trusty64.erb', script: 'ruby'}]

namespace :build do
  # standard box types
  @distros.each do |distro|
    FileList["#{distro}/*.erb"].each do |template_path|
      template = IO.read(template_path)
      template_name = template_path.gsub(/#{distro}\/|\.erb\z/, '')

      @targets.each do |target|
        @standard_types.each do |type|
          name = "#{template_name}-#{type}-#{target}"
          desc "Build #{name}"
          task name do
            box = Boxes::Builder.new(template_name, type, target)
            result = box.build(template)

            if result
              box.clean
            end
          end

          task :default => name
        end
      end
    end
  end

  # special box types
  @special_types.each do |type|
    name = type[:name]
    template = IO.read(type[:template])
    template_name = /([a-z0-9]*?)(?=\.erb)/.match(type[:template])

    @targets.each do |target|
    desc "Build #{name}-#{target}"
      task "#{name}-#{target}" do
        box = Boxes::Builder.new(template_name, type[:script], target)
        result = box.build(template)

        if result
          box.clean
        end
      end

      task :default => "#{name}-#{target}"
    end
  end
end

desc 'Clean up any temporary directories and files'
task :clean do
  FileUtils.rm_rf('tmp')
  FileUtils.rm_rf('packer_cache')
  FileUtils.rm_rf Dir.glob('*.log')
end

desc 'Build all of the configurations'
task :default => 'build:default'
