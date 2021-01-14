require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @user1 = create(:user)
    @user2 = create(:user)
    @relationship = create(:relationship, follower_id: @user1.id, followed_id: @user2.id)
  end

  it 'should be valid' do
    expect(@relationship).to be_valid
  end
  
  describe 'follower id' do
    it 'should be required' do
      @relationship.follower_id = nil
      expect(@relationship).not_to be_valid
    end
  end

  describe 'followed id' do
    it 'should be required' do
      @relationship.followed_id = nil
      expect(@relationship).not_to be_valid
    end
  end
end
