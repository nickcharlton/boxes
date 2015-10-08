require 'fileutils'
require 'pathname'
require 'yaml'
require 'open3'

require 'claide'
require 'colored'

require 'boxes/version'
require 'boxes/errors'
require 'boxes/config'
require 'boxes/subprocess'
require 'boxes/environment'
require 'boxes/template'
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
