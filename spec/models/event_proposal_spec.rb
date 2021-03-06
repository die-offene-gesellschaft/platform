require 'rails_helper'

RSpec.describe EventProposal, type: :model do
  before(:each) do
    @event_proposal = FactoryGirl.create(:event_proposal)
  end

  it 'should have a valid factory' do
    expect(@event_proposal).to be_valid
  end

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:venue) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:organizer) }
  it { should validate_presence_of(:contact_person_forename) }
  it { should validate_presence_of(:contact_person_surname) }
  it { should validate_presence_of(:contact_person_mail) }
  it { should validate_presence_of(:symbol_for_open_society) }
  it { should validate_presence_of(:terms_of_use) }

  describe 'terms_of_use' do
    it 'cannot be false' do
      @event_proposal.terms_of_use = false
      expect(@event_proposal).to be_invalid
    end

    it 'has to be accepted' do
      @event_proposal.terms_of_use = true
      expect(@event_proposal).to be_valid
    end
  end

  describe 'contact_person_mail' do
    it 'should not be an invalid email' do
      ['foo@', 'foo @bar', 'f o@b a.com', '@bar.com'].each do |invalid_email|
        @event_proposal.contact_person_mail = invalid_email
        expect(@event_proposal).to be_invalid
      end
    end

    it 'should be a valid email' do
      ['foo@bar.com', 'john.doe@example.com', 'johnny_doe90@gmail.com'].each do |valid_email|
        @event_proposal.contact_person_mail = valid_email
        expect(@event_proposal).to be_valid
      end
    end
  end

  describe 'logo' do
    it 'should be at least 500x500px big' do
      @event_proposal.logo = File.open("#{Rails.root}/spec/fixtures/images/test.jpg")
      expect(@event_proposal).to be_valid
    end

    it 'should not be smaller than 500x500px' do
      @event_proposal.logo = File.open("#{Rails.root}/spec/fixtures/images/smaller-than-500x500.jpg")
      expect(@event_proposal).to be_invalid
    end
  end

  describe 'picture' do
    it 'should be at least 500x500px big' do
      @event_proposal.picture = File.open("#{Rails.root}/spec/fixtures/images/test.jpg")
      expect(@event_proposal).to be_valid
    end

    it 'should not be smaller than 500x500px' do
      @event_proposal.picture = File.open("#{Rails.root}/spec/fixtures/images/smaller-than-500x500.jpg")
      expect(@event_proposal).to be_invalid
    end
  end
end
