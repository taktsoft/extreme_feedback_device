require 'spec_helper'
require 'extreme_feedback_device'

describe ExtremeFeedbackDevice::CLI do
  context "#instance" do
    it "returns an instance of CLI" do
      ExtremeFeedbackDevice::CLI.instance.should be_a ExtremeFeedbackDevice::CLI
    end
  end

  context ".main" do
    before(:each) do
      ExtremeFeedbackDevice.stub(:run)
      ExtremeFeedbackDevice.stub(:infiniti_loop)
      PidFile.stub(:new)

      subject.stub(:argv).and_return([])
      subject.stub(:parse_opts!)
      subject.stub(:puts_help)
      subject.stub(:puts_version)
      subject.stub(:exit)
    end

    it "calls parse_opts!" do
      subject.should_receive(:parse_opts!)
      subject.main
    end

    it "exits with null by default" do
      subject.should_receive(:exit).with(0)
      subject.main
    end

    it "calls ExtremeFeedbackDevice.run by default" do
      ExtremeFeedbackDevice.should_receive(:run)
      ExtremeFeedbackDevice.should_not_receive(:infiniti_loop)
      subject.main
    end
  end

  context ".mode" do
    it "returns default value if not set" do
      subject.mode.should eql ExtremeFeedbackDevice::CLI::DEFAULT_MODE
    end
  end

  context ".namespace" do
    it "returns default value if not set" do
      subject.namespace.should eql ExtremeFeedbackDevice::CLI::DEFAULT_NAMESPACE
    end
  end

  context ".pid" do
    it "returns default value if not set" do
      subject.pid.should eql ExtremeFeedbackDevice::CLI::DEFAULT_PID
    end
  end

  context ".settings" do
    it "returns default value if not set" do
      subject.settings.should eql ExtremeFeedbackDevice::CLI::DEFAULT_SETTINGS
    end
  end
end