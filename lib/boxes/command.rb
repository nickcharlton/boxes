require 'claide'
require 'colored'

module Boxes
  # Class which encapsulates the command line handling.
  class Command < CLAide::Command
    self.abstract_command = true
    self.command = 'boxes'
    self.description = 'Toolkit for building Vagrantboxes, VM and cloud images.'
  end
end
