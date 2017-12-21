require "acceptance_helper"

RSpec.describe "Misc" do
  it "successfully lists it's version" do
    run_command("boxes --version")

    expect(response).to have_exit_status(0)
    expect(response).to write_to_stdout("#{Boxes::VERSION}\n")
  end
end
