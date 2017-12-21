require "spec_helper"
require "boxes/testing"

RSpec.describe Boxes::Testing::Matchers::HaveExitStatusMatcher do
  context "when an exit status matches" do
    it "passes" do
      expected = mock_command(status: 10)

      instance = described_class.new(10)
      outcome = instance.matches?(expected)

      expect(outcome).to be(true)
    end
  end

  context "when an exit status is different" do
    it "fails with a message" do
      expected = mock_command(cmd: "cmd", status: 10)

      instance = described_class.new(0)
      outcome = instance.matches?(expected)

      expect(outcome).to be(false)
      expect(instance.failure_message).to eq(
        "expected that `cmd` would exit with 0",
      )
    end
  end

  def mock_command(cmd: nil, status: nil)
    double("Command::Response", cmd: cmd, exit_status: status)
  end
end
