require 'rails_helper'

RSpec.describe Location, type: :model do
  it { should have_one(:venue) }
end
