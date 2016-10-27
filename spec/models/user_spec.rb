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

  it { should validate_length_of(:role).is_at_most(140) }
  it { should validate_length_of(:statement).is_at_most(255) }

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

  describe 'avatar' do
    it 'should be at least 500x500px big' do
      @user.avatar = File.open("#{Rails.root}/spec/fixtures/images/test.jpg")
      expect(@user).to be_valid
    end

    it 'should not be smaller than 500x500px' do
      @user.avatar = File.open("#{Rails.root}/spec/fixtures/images/smaller-than-500x500.jpg")
      expect(@user).to be_invalid
    end
  end

  describe 'video_url' do
    it 'can be nil' do
      @user.video_url = nil
      expect(@user).to be_valid
    end

    it 'can be an empty string' do
      @user.video_url = ''
      expect(@user).to be_valid
    end

    it 'can be a string consisting only of whitespace' do
      @user.video_url = '  '
      expect(@user).to be_valid
    end

    it 'can be a valid YouTube URL' do
      @user.video_url = 'https://www.youtube.com/watch?v=T0o3UN8pEro'
      expect(@user).to be_valid
    end

    it 'can be a valid YouTube URL' do
      @user.video_url = 'https://youtu.be/T0o3UN8pEro'
      expect(@user).to be_valid
    end

    it 'cannot be a YouTube URL not referencing to a video' do
      @user.video_url = 'https://www.youtube.com/user/BritnyFoxVEVO'
      expect(@user).to be_invalid
    end

    it 'can be valid Vimeo URL' do
      @user.video_url = 'https://vimeo.com/175228896'
      expect(@user).to be_valid
    end

    it 'cannot be a Vimeo URL not referencing to a video' do
      @user.video_url = 'https://vimeo.com/user49816848'
      expect(@user).to be_invalid
    end

    it 'cannot be an other URL than a YouTube or Vimeo video URL' do
      @user.video_url = 'https://example.com/foobar'
      expect(@user).to be_invalid
    end
  end
end
