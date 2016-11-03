require 'rails_helper'

RSpec.describe Blogpost, type: :model do
  it { should validate_uniqueness_of(:slug) }
end
