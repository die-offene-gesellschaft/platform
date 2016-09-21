require 'rails_helper'

RSpec.describe Newsletter, type: :model do
  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:email) }
end
