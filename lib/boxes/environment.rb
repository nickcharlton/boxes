module Boxes
  # For creating and managing the environment which boxes uses.
  class Environment
    def initialize
      FileUtils.mkdir_p(Boxes.config.working_dir)

      copy_templates
      copy_scripts
    end

    def available_templates
      t = Dir.glob("#{Boxes.config.working_dir}/templates/*/**")
      a = t.collect { |c| c.include?('preseed.cfg') ? next : c }.compact

      a.collect do |c|
        c = c.gsub(Boxes.config.working_dir.to_s + '/templates/', '')
        c.gsub('.erb', '')
      end
    end

    def hidden_templates
      t = Dir.glob("#{Boxes.config.working_dir}/templates/*/**")
      a = t.collect { |c| c.include?('preseed.cfg') ? c : next }.compact

      a.collect do |c|
        c.gsub(Boxes.config.working_dir.to_s + '/templates/', '')
      end
    end

    def available_scripts
      t = Dir.glob("#{Boxes.config.working_dir}/scripts/*")
      a = t.collect { |c| c.include?('purge.sh') ? next : c }.compact

      a.collect do |c|
        c.gsub(Boxes.config.working_dir.to_s + '/scripts/', '')
      end
    end

    def hidden_scripts
      t = Dir.glob("#{Boxes.config.working_dir}/scripts/*")
      a = t.collect { |c| c.include?('purge.sh') ? c : next }.compact

      a.collect do |c|
        c.gsub(Boxes.config.working_dir.to_s + '/scripts/', '')
      end
    end

    private

    def copy_templates
      templates_dir = Boxes.config.working_dir + 'templates'

      FileUtils.mkdir_p(templates_dir)

      Boxes.config.template_paths.each do |template_path|
        Dir.glob("#{template_path}/*").each do |src_template|
          FileUtils.cp_r(src_template, templates_dir)
        end
      end
    end

    def copy_scripts
      scripts_dir = Boxes.config.working_dir + 'scripts'

      FileUtils.mkdir_p(Boxes.config.working_dir + 'scripts')

      Boxes.config.script_paths.each do |script_path|
        Dir.glob("#{script_path}/*").each do |src_script|
          FileUtils.cp_r(src_script, scripts_dir)
        end
      end
    end
  end
end
