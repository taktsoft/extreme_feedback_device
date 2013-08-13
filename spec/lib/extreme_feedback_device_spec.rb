require 'spec_helper'
require 'extreme_feedback_device'

describe ExtremeFeedbackDevice do
  context "#settings" do
    it "returns a ExtremeFeedbackDevice::Settings" do
      ExtremeFeedbackDevice.settings.should be_a Class
    end
  end

  context "#jenkins" do
    it "returns a ExtremeFeedbackDevice::Jenkins" do
      ExtremeFeedbackDevice.jenkins.should be_a ExtremeFeedbackDevice::Jenkins
    end
  end

  context "#pi" do
    it "returns a ExtremeFeedbackDevice::Pi" do
      ExtremeFeedbackDevice.pi.should be_a ExtremeFeedbackDevice::Pi
    end
  end

  context "#run" do
  end

  context "#loop" do
  end
end