require 'boxes/version'
require 'boxes/errors'
require 'boxes/config'
require 'boxes/utils/template'
require 'boxes/environment'
require 'boxes/builder'
require 'boxes/command'

# Toolkit for building Vagrantboxes, VM and cloud images.
module Boxes
  class << self
    attr_reader :config

    def config
      @config ||= Config.new
    end
  end
end
