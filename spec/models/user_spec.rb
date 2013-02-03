require 'spec_helper'

describe User do
  it "is valid when created properly" do
    user = build(:han_solo)
    user.should be_valid
  end

  it "is not valid when password is less than six characters" do
    user = build(:han_solo, password: '12345')
    user.should_not be_valid
  end
end
