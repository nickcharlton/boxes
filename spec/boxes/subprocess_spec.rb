require 'spec_helper'

describe Boxes::Subprocess do
  let(:command) do
    File.expand_path("../../support/subprocess_command.sh", __FILE__).
      shellescape
  end

  it 'runs a command and yields a block' do
    expect { |b| Boxes::Subprocess.run(command, &b) }.to yield_control
  end

  it 'runs a command and returns stdout' do
    total_stdout = ''
    Boxes::Subprocess.run(command) do |stdout, _stderr, _thread|
      total_stdout << stdout
    end

    expect(total_stdout).to eq "A happy output.\n"
  end

  it 'runs a command and returns stderr' do
    total_stderr = ''
    Boxes::Subprocess.run(command) do |_stdout, stderr, _thread|
      total_stderr << stderr
    end

    expect(total_stderr).to eq "An unhappy output.\n"
  end

  it 'returns a status code' do
    status = Boxes::Subprocess.run(command) { |_stdout, _stderr, _thread| }

    expect(status.exitstatus).to eq 5
  end
end
