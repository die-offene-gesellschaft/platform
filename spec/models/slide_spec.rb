RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryGirl.create(:slide)

    it 'should have a valid factory' do
      expect(@user).to be_valid
    end
  end
end