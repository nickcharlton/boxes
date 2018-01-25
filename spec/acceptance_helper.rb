require "boxes/testing"

require "support/env"
require "support/tmp"

RSpec.configure do |config|
  include Boxes::Testing::Matchers
  include Boxes::Testing::Command

  config.around(:each) do |example|
    Dir.chdir("spec/tmp") do
      example.run
    end
  end
end
