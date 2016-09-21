require 'rails_helper'

RSpec.describe Statement, type: :model do
  it { should belong_to(:event) }
end
