require 'spec_helper'
require 'extreme_feedback_device/cli'

describe ExtremeFeedbackDevice::CLI do
  context "#instance" do
    it "returns an instance of CLI" do
      ExtremeFeedbackDevice::CLI.instance.should be_a ExtremeFeedbackDevice::CLI
    end
  end
end