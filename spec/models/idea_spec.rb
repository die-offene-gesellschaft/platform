require 'rails_helper'

RSpec.describe Idea, type: :model do
  before(:each) do
    @idea = FactoryGirl.create(:idea)
  end

  it 'should have a valid factory' do
    expect(@idea).to be_valid
  end

  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:time) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:contact_person) }
  it { should validate_presence_of(:email) }

  it { should validate_length_of(:contact_person).is_at_most(140) }
  it { should validate_length_of(:organisation).is_at_most(140) }
  it { should validate_length_of(:email).is_at_most(140) }
  it { should validate_length_of(:phone).is_at_most(140) }

  it { should validate_length_of(:subject).is_at_most(255) }
  it { should validate_length_of(:time).is_at_most(255) }
  it { should validate_length_of(:location).is_at_most(255) }

  describe 'email' do
    it 'should not be an invalid email' do
      ['foo@', 'foo @bar', 'f o@b a.com', '@bar.com'].each do |invalid_email|
        @idea.email = invalid_email
        expect(@idea).to be_invalid
      end
    end

    it 'should be a valid email' do
      ['foo@bar.com', 'john.doe@example.com', 'johnny_doe90@gmail.com'].each do |valid_email|
        @idea.email = valid_email
        expect(@idea).to be_valid
      end
    end
  end
end
