module Boxes
  class Command < CLAide::Command
    require "boxes/command/build"
    require "boxes/command/env"

    self.abstract_command = true
    self.command = "boxes"
    self.version = VERSION
    self.description = "A command line tool that takes the complexity out " \
                       "of building Vagrant boxes."
  end
end
