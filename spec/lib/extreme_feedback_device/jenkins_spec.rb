require 'spec_helper'
require 'extreme_feedback_device/jenkins'

describe ExtremeFeedbackDevice::Jenkins do
  context ".user" do
    it "responds to user" do
      subject.should be_respond_to "user"
    end

    it "responds to user=" do
      subject.should be_respond_to "user="
    end
  end

  context ".token" do
    it "responds to token" do
      subject.should be_respond_to "token"
    end

    it "responds to token=" do
      subject.should be_respond_to "token="
    end
  end

  context ".base_url" do
    it "responds to base_url" do
      subject.should be_respond_to "base_url"
    end

    it "responds to base_url=" do
      subject.should be_respond_to "base_url="
    end
  end

  context ".full_url" do
    it "joins parts correctly" do
      subject.base_url = "http://localhost/"
      subject.full_url.should eql "http://localhost/api/json?tree=jobs[name,color,healthReport[score]]"
    end
  end

  context ".full_uri" do
    it "returns an URI" do
      subject.base_url = "http://localhost/"
      subject.full_uri.should be_a URI
    end
  end

  context ".jobs" do
    context "without mocked JSON" do
      it "returns nil if host isn't available" do
        subject.base_url = "http://this-host-isnt-available/"
        subject.jobs.should be_nil
      end
    end

    context "with mocked JSON" do
      let(:response) { '''{"jobs":[
        {"name":"Project X - Master","color":"blue","healthReport":[{"score":80}]},
        {"name":"Project X - Production","color":"blue","healthReport":[{"score":60}]},
        {"name":"Project Y - Master","color":"blue","healthReport":[{"score":100}]},
        {"name":"Project Y - Production","color":"blue","healthReport":[{"score":40}]}
      ]}''' }

      before(:each) do
        subject.stub(:get_json).and_return(response)
      end

      it "returns exactly four jobs" do
        subject.jobs.should have(4).items
      end
    end
  end
end