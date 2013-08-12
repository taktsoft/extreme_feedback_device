require 'spec_helper'
require 'extreme_feedback_device/job'

describe ExtremeFeedbackDevice::Job do
  context ".name" do
    it "responds to name" do
      subject.should be_respond_to "name"
    end

    it "responds to name=" do
      subject.should be_respond_to "name="
    end
  end

  context ".color" do
    it "responds to color" do
      subject.should be_respond_to "color"
    end

    it "responds to color=" do
      subject.should be_respond_to "color="
    end
  end

  context ".fail?" do
    it "returns correct answer" do
      subject.color = 'red'
      subject.should be_fail
      subject.color = 'red_anime'
      subject.should be_fail
    end
  end

  context ".unstable?" do
    it "returns correct answer" do
      subject.color = 'yellow'
      subject.should be_unstable
      subject.color = 'yellow_anime'
      subject.should be_unstable
    end
  end
  context ".success?" do
    it "returns correct answer" do
      subject.color = 'blue'
      subject.should be_success
      subject.color = 'blue_anime'
      subject.should be_success
    end
  end

  context ".disabled?" do
    it "returns correct answer" do
      subject.color = 'disabled'
      subject.should be_disabled
      subject.color = 'disabled_anime'
      subject.should be_disabled
    end
  end

  context ".health" do
    it "responds to health" do
      subject.should be_respond_to "health"
    end

    it "responds to health=" do
      subject.should be_respond_to "health="
    end
  end

  context "#from_json_object" do
    let(:klass) { ExtremeFeedbackDevice::Job }
    let(:json_object) { {"name"=>"Project X - Master", "color"=>"blue", "healthReport"=>[{"score"=>80}]} }

    it "sets attributes correctly" do
      subject = klass.from_json_object(json_object)
      subject.should be_a klass
      subject.name.should eql "Project X - Master"
      subject.color.should eql "blue"
      subject.health.should eql 80
    end

    it "doesn't raise error if healthReport is empty" do
      json_object["healthReport"].clear
      subject = klass.from_json_object(json_object)
      subject.should be_a klass
      subject.name.should eql "Project X - Master"
      subject.color.should eql "blue"
      subject.health.should eql nil
    end
  end
end