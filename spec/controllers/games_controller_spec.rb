require 'spec_helper'

describe GamesController do
  let!(:game) { FactoryGirl.create(:borderlands) }

  describe "GET index" do
    before do
      get :index
    end
    it { assigns(:games).should include(game) }
    it { should respond_with(:success) }
    it { should render_template(:index) }
  end

  describe "GET show" do
    before do
      get :show, id: game.to_param
    end
    it { assigns(:game).should eq(game) }
    it { should respond_with(:success) }
    it { should render_template(:show) }
  end

  describe "GET new" do
    before do
      get :new
    end
    it { assigns(:game).should be_a_new(Game) }
    it { should respond_with(:success) }
    it { should render_template(:new) }
  end

  describe "POST create" do

    context "with valid attributes" do
      before do
        post :create, game: { title: 'Halo 4', image_url: 'image.com/img.jpg' }
      end
      it { should respond_with(:redirect) }
      it "saves the new game in the database" do
        Game.find_by_title('Halo 4').should_not be_nil
      end
    end

    context "with invalid attributes" do
      before do
        post :create, game: { title: 'Starcraft 2', image_url: '' }
      end
      xit { should render_template(:new) }
      xit "does not save the new game in the database" do
        Game.find_by_title('Starcraft 2').should be_nil
      end
    end
  end

  describe "GET edit" do
    before do
      get :edit, id: game.to_param
    end
    it { assigns(:game).should eq(game) }
    it { should respond_with(:success) }
    it { should render_template(:edit) }
  end

  describe "PUT update" do

    context "with valid attributes" do
      before do
        post :update, id: game.id, game: { title: 'Skyrim', image_url: 'image.com/img.jpg' }
      end
      it { should respond_with(302) }
      it "saves the new game in the database" do
        Game.find_by_title('Skyrim').should_not be_nil
      end
    end

    context "with invalid attributes" do
      before do
        post :update, id: game.id, game: { title: 'Starcraft 2', image_url: '' }
      end
      xit { should render_template(:new) }
      xit "does not save the new game in the database" do
        Game.find_by_title('Starcraft 2').should be_nil
      end
    end

  end

  describe "DELETE destroy" do
    before do
      delete :destroy, id: game.id
    end
    it { should redirect_to(games_url) }
    it "should delete the game" do
      Game.find_by_id(game.id).should be_nil
    end
  end
end
