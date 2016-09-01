require 'rails_helper'

RSpec.describe ActiveMember, type: :model do
  it { should have_and_belong_to_many(:events) }

  it { should validate_presence_of(:forename) }
  it { should validate_presence_of(:surname) }
end
