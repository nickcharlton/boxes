require 'spec_helper'

describe Boxes::Subprocess do
  let(:command) do
    File.expand_path 'spec/support/subprocess_command.rb'
  end

  it 'runs a command and yields a block' do
    expect { |b| Boxes::Subprocess.run(command, &b) }.to yield_control
  end

  it 'runs a command and returns stdout' do
    Boxes::Subprocess.run(command) do |stdout, _stderr, _thread|
      expect(stdout).to eq 'A happy output.'
    end
  end

  it 'runs a command and returns stderr' do
    Boxes::Subprocess.run(command) do |_stdout, stderr, _thread|
      expect(stderr).to eq 'An unhappy output.'
    end
  end

  it 'returns a status code' do
    status = Boxes::Subprocess.run(command) { |_stdout, _stderr, _thread| }

    expect(status.exitstatus).to eq 5
  end
end
