require "spec_helper"

describe UsersController do
  describe "routing" do

    it "routes /login to sessions#new" do
      get("/login").should route_to("devise/sessions#new")
    end

    it "routes /logout to sessions#destroy" do
      delete("/logout").should route_to("devise/sessions#destroy")
    end

  end
end
