require 'rails_helper'

RSpec.describe ActiveMember, type: :model do
  it { should belong_to(:event) }

  it { should validate_presence_of(:forename) }
  it { should validate_presence_of(:surname) }
end
