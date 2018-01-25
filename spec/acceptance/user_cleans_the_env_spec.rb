require "acceptance_helper"

RSpec.describe "User cleans the env" do
  describe "boxes env" do
    it "shows the environment details" do
      mktmpdir

      with_modified_env(BOXES_WORKING_DIR: tmpdir.to_s) do
        run_command("boxes env clean")
      end

      expect(tmpdir).not_to exist
    end
  end
end
