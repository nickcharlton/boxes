require "spec_helper"
require "boxes/testing/command"

RSpec.describe Boxes::Testing::Command do
  include described_class

  describe "#run_command" do
    context "with output" do
      it "returns the result of stdout" do
        run_command("echo 'Hello World!'")

        expect(response).to have_attributes(cmd: "echo 'Hello World!'",
                                            stdout: "Hello World!\n",
                                            exit_status: 0)
      end
    end

    context "with an exit status" do
      it "returns the custom exit code" do
        run_command("exit 1")

        expect(response).to have_attributes(cmd: "exit 1",
                                            stdout: "",
                                            exit_status: 1)
      end
    end
  end
end
