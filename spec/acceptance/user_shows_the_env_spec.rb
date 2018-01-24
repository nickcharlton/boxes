require "acceptance_helper"

RSpec.describe "User shows the env" do
  describe "boxes env" do
    it "shows the environment details" do
      run_command("boxes env")

      expect(response).to have_exit_status(0)
      expect_response_to_show_environment_details
    end
  end

  describe "boxes env show" do
    it "shows the environment details" do
      run_command("boxes env show")

      expect(response).to have_exit_status(0)
      expect_response_to_show_environment_details
    end
  end

  def expect_response_to_show_environment_details
    expect(response.stdout).to include(
      "WORKING_DIR=\"#{home_path('.boxes/tmp')}",
    )
    expect(response.stdout).to include("HOME_DIR=\"#{home_path('.boxes')}\"")

    expect(response.stdout).to include(
      "TEMPLATE_PATHS=\"#{project_path('templates')}\"",
    )

    expect(response.stdout).to include(
      "SCRIPT_PATHS=\"#{project_path('scripts')}\"",
    )

    expect(response.stdout).to include(
      "PACKER_CACHE_DIR=\"#{home_path('.boxes/packer_cache')}",
    )
  end

  def project_path(subpath)
    project_root = Pathname.new("../../").expand_path
    project_root.join(subpath)
  end

  def home_path(subpath)
    Pathname.new(Dir.home).join(subpath)
  end
end
