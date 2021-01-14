require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create(:user)
  end

  it 'should be valid' do
    expect(@user).to be_valid
  end

  describe 'name' do
    it 'should be present' do
      @user.name = '  '
      expect(@user).not_to be_valid
    end
    it 'should not be too long' do
      @user.name = "a" * 51
      expect(@user).not_to be_valid
    end
  end
  
  describe 'email' do
    it 'should be present' do
      @user.email = "  "
      expect(@user).not_to be_valid
    end
    it 'should not be too long' do
      @user.name = "a" * 244 + '@example.com'
      expect(@user).not_to be_valid
    end
    it "validation should accept valid addresses" do
      valid_addresses = %w[user@example.com
                           USER@foo.COM
                           A_US-ER@foo.bar.org
                           first.last@foo.jp
                           alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user.valid?).to be_truthy
      end
    end
    it "validation should reject invalid addresses" do
      invalid_addresses = %w[user@example,com
                             user_at_foo.org
                             user.name@example.
                             foo@bar_baz.com
                             foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user.valid?).to be_falsey
      end
    end
    it "addresses should be unique" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      expect(duplicate_user).not_to be_valid
    end
    it "addresses should be saved as lower-case" do
      mixed_case_email = "Foo@ExAMPle.CoM"
      @user.email = mixed_case_email
      @user.save
      expect(mixed_case_email.downcase).to eq(@user.reload.email)
    end
  end

  describe 'password' do
    it "should be present (nonblank)" do
      @user.password = @user.password_confirmation = " " * 6
      expect(@user).not_to be_valid
    end
    
    it "should have a minimum length" do
      @user.password = @user.password_confirmation = "a" * 5
      expect(@user).not_to be_valid
    end
  
    it "authenticated?(the sessions helper) should return false fo a user with nil digest" do
      expect(@user.authenticated?('')).to be_falsey
    end
  end

  describe 'associated microposts' do
    it 'should be destroyed' do
      @user.microposts.create!(content: "Lorem ipsum")
      expect{ @user.destroy }.to change{ Micropost.count }.by(-1)
    end
  end

  describe 'follow / unfollow' do
    before do
      @user1 = create(:user)
      @user2 = create(:user)
      @user1.follow(@user2)
    end
    it 'should follow a user' do
      expect(@user1.following?(@user2)).to be_truthy
      expect(@user2.followers).to include(@user1)
    end
    it 'should unfollow a user' do
      @user1.unfollow(@user2)
      expect(@user1.following?(@user2)).not_to be_truthy
      expect(@user2.followers).not_to include(@user1)
    end
  end

  describe 'feed' do
    before do
      @user1 = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
      @user1.follow(@user2)
    end
    it 'should have my own posts' do
      @user1.microposts.each do |post_self|
        expect(@user1.feed).to include(post_self)
      end
    end
    it 'should have the following users posts' do
      @user2.microposts.each do |post_following|
        expect(@user1.feed).to include(post_following)
      end
    end
    it 'should not have unfollowing users posts' do
      @user3.microposts.each do |post_unfollowed|
        expect(@user1.feed).not_to include(post_unfollowed)
      end
    end
  end
end
