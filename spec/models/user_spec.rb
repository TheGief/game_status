require 'spec_helper'

describe User do
  it "is valid when created properly" do
    @user = FactoryGirl.build(:han_solo)
    @user.should be_valid
  end
end
