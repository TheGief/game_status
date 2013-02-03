require 'spec_helper'

describe RegistrationsController do

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:han_solo)
    @user.confirm!
    sign_in @user
  end

  describe "PUT update" do

    context "with basic info, leaving password fields blank," do
      before do
        put :update, id: @user.id, user: attributes_for(
          :han_solo, username: 'FalconOwner', password: nil
        )
      end

      it { should respond_with(:redirect) }
      it "should update the user" do
        @user.reload
        @user.username.should == 'FalconOwner'
      end
    end

    context "with new password," do
      context "without including current password," do
        before do
          put :update, id: @user.id, user: attributes_for(
            :han_solo, username: 'FalconOwner',
            password: 'Falcon-4life',
            password_confirmation: 'Falcon-4life'
          )
        end

        it { should render_template(:edit) }
        it "should not update the user" do
          @user.reload
          @user.username.should == 'HanSolo'
          @user.password.should_not == 'Falcon-4life'
        end
      end

      context "including the correct current password," do
        before do
          put :update, id: @user.id, user: attributes_for(
            :han_solo, username: 'FalconOwner',
            current_password: @user.password,
            password: 'Falcon-4life',
            password_confirmation: 'Falcon-4life'
          )
        end

        it { should respond_with(:redirect) }
        it "should update the user" do
          @user.reload
          @user.username.should == 'FalconOwner'
        end
      end
    end
  end
end