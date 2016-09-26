require 'rails_helper'

RSpec.describe Newsletter, type: :model do
  it { should validate_presence_of(:forename) }

  it { should validate_presence_of(:surname) }

  it { should validate_presence_of(:email) }
end
