require 'rails_helper'

RSpec.describe Picture, type: :model do
  it { should belong_to(:user) }

  it { should belong_to(:event) }

  it { should validate_presence_of(:picture) }
end
