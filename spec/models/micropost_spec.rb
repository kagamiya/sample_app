require 'rails_helper'

RSpec.describe Micropost, type: :model do
  before do
    @user = create(:user)
    @micropost = create(:micropost, user_id: @user.id)
    @most_recent = create(:micropost, user_id: @user.id)
  end

  it 'should be valid' do
    expect(@micropost).to be_valid
  end

  describe 'user id' do
    it 'should be present' do
      @micropost.user_id = nil
      expect(@micropost).not_to be_valid
    end
  end
  
  describe 'content' do
    it 'shoud be present' do
      @micropost.content = "  "
      expect(@micropost).not_to be_valid
    end
    it 'should be at most 140 characters' do
      @micropost.content = "a" * 141
      expect(@micropost).not_to be_valid
    end
    it 'order should be most recent first' do
      expect(@most_recent).to eq(Micropost.first)
    end
  end
end
