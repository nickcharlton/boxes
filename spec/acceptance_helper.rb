require "boxes/testing"

RSpec.configure do |config|
  include Boxes::Testing::Matchers
  include Boxes::Testing::Command

  config.around(:each) do |example|
    Dir.chdir("spec/tmp") do
      example.run
    end
  end
end
