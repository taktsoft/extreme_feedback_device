require 'spec_helper'
require 'extreme_feedback_device/cli'

describe ExtremeFeedbackDevice::CLI do
  context "#instance" do
    it "returns an instance of CLI" do
      ExtremeFeedbackDevice::CLI.instance.should be_a ExtremeFeedbackDevice::CLI
    end
  end

  context "with mocked ARGV" do
    let(:argv) { ["jenkinsUser", "jenkinsToken", "http://localhost/jenkins"] }
    let(:subject) { ExtremeFeedbackDevice::CLI.new(argv) }

    it "returns correct jenkins user" do
      subject.jenkins_user.should eql "jenkinsUser"
    end

    it "returns correct jenkins token" do
      subject.jenkins_token.should eql "jenkinsToken"
    end

    it "returns correct jenkins url" do
      subject.jenkins_url.should eql "http://localhost/jenkins"
    end

    it "returns correct spi device" do
      subject.spi_device.should be_nil

      subject.argv << "/dev/fake/spidev0.0"
      subject.spi_device.should eql "/dev/fake/spidev0.0"
    end
  end
end