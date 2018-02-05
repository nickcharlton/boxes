require "acceptance_helper"

RSpec.describe "User builds box" do
  describe "boxes build" do
    it "shows help when the name option is missing" do
      run_command("boxes build --provider=vmware --template=debian/jessie64")

      expect(response).to have_exit_status(1)
      expect(response.stdout).to include("[!] A name is required!")
      expect_response_to_show_build_help
    end

    it "shows help when the provider option is missing" do
      run_command("boxes build --name=example --template=debian/jessie64")

      expect(response).to have_exit_status(1)
      expect(response.stdout).to include("[!] A provider is required!")
      expect_response_to_show_build_help
    end

    it "shows help when the template option is missing" do
      run_command("boxes build --name=example --provider=vmware")

      expect(response).to have_exit_status(1)
      expect(response.stdout).to include("[!] A template is required!")
      expect_response_to_show_build_help
    end
  end

  def expect_response_to_show_build_help
    expect(response.stdout).to include(
      "Builds boxes using templates and scripts.",
    )

    expect(response.stdout).to include(
      "--name                           The name for the build",
    )

    expect(response.stdout).to include(
      "--provider=[virtualbox|vmware]   The provider to build the box for",
    )

    expect(response.stdout).to include(
      "--template                       Template to build the box with",
    )

    expect(response.stdout).to include(
      "--scripts                        Scripts to apply to the box",
    )
  end
end
