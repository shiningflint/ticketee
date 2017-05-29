require 'rails_helper'

RSpec.describe Admin::ApplicationController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    allow(controller).to receive(:authenticate_user!)
    allow(controller).to receive(:current_user).and_return(user)
  end

  context "non-admin users" do
    it "are not able to access the index action" do
      get :index

      expect(response).to redirect_to "/"
      expect(flash[:alert]).to eq "You must be an admin to do that."
    end
  end

end

#This is a controller test. It is different from the feature test.
#The purpose of this controller test is obviously to test the controller, not the feature
#The 'Controller' method returns the instance of the controller that will be used during this test.
#The 'Allow' method allows you to fake method responses on that object
#In this test, you intercept current_user method, and replacing it with user
