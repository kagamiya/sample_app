require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do
    @user = build(:user)
    @other_user = build(:user)
  end

  describe 'new' do
    it 'should get' do
      get :new
      expect(response).to be_success
    end
  end

  describe 'index' do
    it 'should redirect when not logged in' do
      get :index
      expect(response).to redirect_to login_url
    end
  end
  
  describe 'edit' do
    it 'should redirect when not logged in' do
    end
  end
end
