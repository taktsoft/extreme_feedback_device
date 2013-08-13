require 'spec_helper'
require 'extreme_feedback_device/cli'

describe ExtremeFeedbackDevice::CLI do
  let(:subject) { ExtremeFeedbackDevice::CLI.new([]) }

  context "#instance" do
    it "returns an instance of CLI" do
      ExtremeFeedbackDevice::CLI.instance.should be_a ExtremeFeedbackDevice::CLI
    end
  end

  context "with mocked ARGV" do
    it "returns correct mode" do
      subject.argv[0] = 'run'
      subject.mode.should eql "run"
      subject.argv[0] = 'loop'
      subject.mode.should eql "loop"
    end

    context ".main" do
      it "calls ExtremeFeedbackDevice.run in mode run" do
        ExtremeFeedbackDevice.should_receive(:run)
        subject.argv[0] = 'run'
        subject.main
      end

      it "calls ExtremeFeedbackDevice.infiniti_loop in mode loop" do
        ExtremeFeedbackDevice.should_receive(:infiniti_loop)
        subject.argv[0] = 'loop'
        subject.main
      end
    end
  end
end