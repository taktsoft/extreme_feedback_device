require 'spec_helper'
require 'extreme_feedback_device/cli'

describe ExtremeFeedbackDevice::CLI do
  context "#instance" do
    it "returns an instance of CLI" do
      ExtremeFeedbackDevice::CLI.instance.should be_a ExtremeFeedbackDevice::CLI
    end
  end

  context "with mocked ARGV" do
    let(:argv) { ["run", "spec/extreme_feedback_device.yml"] }
    let(:subject) { ExtremeFeedbackDevice::CLI.new(argv) }

    it "returns correct jenkins user" do
      subject.mode.should eql "run"
    end

    it "returns correct settings_yml" do
      subject.settings_yml.should eql "spec/extreme_feedback_device.yml"
    end
  end
end