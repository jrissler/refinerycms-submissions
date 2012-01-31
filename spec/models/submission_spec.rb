require 'spec_helper'

describe Submission do

  def reset_submission(options = {})
    @valid_attributes = {
      :id => 1,
      :first_name => "RSpec is great for testing too"
    }

    @submission.destroy! if @submission
    @submission = Submission.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_submission
  end

  context "validations" do
    
    it "rejects empty first_name" do
      Submission.new(@valid_attributes.merge(:first_name => "")).should_not be_valid
    end

    it "rejects non unique first_name" do
      # as one gets created before each spec by reset_submission
      Submission.new(@valid_attributes).should_not be_valid
    end
    
  end

end