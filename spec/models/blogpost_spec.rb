require 'rails_helper'

RSpec.describe Blogpost, type: :model do
  it { should belong_to(:admin) }
end
