require "spec_helper"
require "boxes/testing"

RSpec.describe Boxes::Testing::Matchers::WriteToStdoutMatcher do
  context "when the output matches" do
    it "passes" do
      expected = mock_command(stdout: "Hello World!\n")

      instance = described_class.new("Hello World!\n")
      outcome = instance.matches?(expected)

      expect(outcome).to be(true)
    end
  end

  context "when the output is different" do
    it "fails with a message" do
      expected = mock_command(stdout: "Hello!\n")

      instance = described_class.new("Hello World!\n")
      outcome = instance.matches?(expected)

      expect(outcome).to be(false)
      expect(instance.failure_message).to eq(
        "expected that 'Hello!\\n' would be Hello World!\\n",
      )
    end
  end

  def mock_command(cmd: nil, stdout: nil)
    double("Command::Response", cmd: cmd, stdout: stdout)
  end
end
