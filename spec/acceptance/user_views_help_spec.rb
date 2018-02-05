require "acceptance_helper"

RSpec.describe "User views help" do
  describe "boxes" do
    it "describes the tool" do
      run_command("boxes")

      expect(response).to have_exit_status(0)
      expect(response.stdout).to include(
        "A command line tool that takes the complexity out of " \
        "building Vagrant boxes.",
      )
    end

    it "shows available subcommands" do
      run_command("boxes")

      expect(response).to have_exit_status(0)
      expect(response.stdout).to include(
        "+ build     Build boxes",
      )
      expect(response.stdout).to include(
        "+ env       Manage the build environment",
      )
    end

    it "shows available options" do
      run_command("boxes")

      expect(response).to have_exit_status(0)
      expect(response.stdout).to include(
        "--version   Show the version of the tool",
      )
      expect(response.stdout).to include(
        "--help      Show help banner of specified command",
      )
    end
  end
end
