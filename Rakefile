# encoding: UTF-8

@distros = [:debian, :ubuntu]
@targets = [:virtualbox, :vmware]
@types = [:standard, :chef, :puppet]

namespace :build do
  @distros.each do |distro|
    FileList["#{distro}/*.erb"].each do |template|
      template_name = template.gsub(/#{distro}\/|\.erb\z/, '')

      @targets.each do |target|
        @types.each do |type|
          name = "#{template_name}-#{type}-#{target}"
          desc "Build #{name}"
          task name do
            puts name
          end

          task :default => name
        end
      end
    end
  end
end

desc 'Build all of the configurations'
task :default => 'build:default'
