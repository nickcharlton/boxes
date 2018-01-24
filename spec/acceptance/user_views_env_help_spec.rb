require "acceptance_helper"

RSpec.describe "User views env help" do
  describe "boxes env" do
    it "describes available subcommands" do
      run_command("boxes env --help")

      expect(response).to have_exit_status(0)
      expect(response.stdout).to include(
        "+ clean     Clean up the environment.",
      )

      expect(response.stdout).to include(
        "> show      Show the environment and configuration",
      )
    end
  end
end
