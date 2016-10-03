require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it 'should have a valid factory' do
    expect(@user).to be_valid
  end

  it { should have_many(:pictures) }
  it { should have_many(:comments) }
  it { should have_many(:events) }

  it do
    should have_and_belong_to_many(:participating_events)
      .class_name('Event')
      .join_table('event_participations')
  end

  it do
    should have_and_belong_to_many(:friends)
      .class_name('User')
      .join_table('friendships')
      .with_foreign_key('friend_id')
  end

  it { should validate_presence_of(:forename) }
  it { should validate_presence_of(:surname) }

  describe 'terms of use' do
    it 'can not be unset if not a newsletter user' do
      @user.newsletter = false
      @user.terms_of_use = false
      expect(@user).to be_invalid
    end

    it 'can be unset if newsletter user' do
      @user.newsletter = true
      @user.terms_of_use = false
      expect(@user).to be_valid
    end

    it 'should be set' do
      @user.terms_of_use = true
      expect(@user).to be_valid
    end
  end
end
