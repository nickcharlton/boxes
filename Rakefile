# encoding: UTF-8

require 'fileutils'
require_relative 'lib/boxes'

@distros = %w{debian ubuntu}
@targets = %w{virtualbox vmware}
@types = %w{standard chef puppet}

namespace :build do
  @distros.each do |distro|
    FileList["#{distro}/*.erb"].each do |template_path|
      template = IO.read(template_path)
      template_name = template_path.gsub(/#{distro}\/|\.erb\z/, '')

      @targets.each do |target|
        @types.each do |type|
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
end

desc 'Clean up any temporary directories and files'
task :clean do
  FileUtils.rm_rf('tmp')
  FileUtils.rm_rf('packer_cache')
  FileUtils.rm_rf Dir.glob('*.log')
end

desc 'Build all of the configurations'
task :default => 'build:default'
