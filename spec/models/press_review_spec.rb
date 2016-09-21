require 'rails_helper'

RSpec.describe PressReview, type: :model do
  it { should belong_to(:event) }
end
