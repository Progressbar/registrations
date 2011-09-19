require 'spec_helper'

describe Registration do

  def reset_registration(options = {})
    @valid_attributes = {
      :id => 1,
      :username => "RSpec is great for testing too"
    }

    @registration.destroy! if @registration
    @registration = Registration.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_registration
  end

  context "validations" do
    
    it "rejects empty username" do
      Registration.new(@valid_attributes.merge(:username => "")).should_not be_valid
    end

    it "rejects non unique username" do
      # as one gets created before each spec by reset_registration
      Registration.new(@valid_attributes).should_not be_valid
    end
    
  end

end