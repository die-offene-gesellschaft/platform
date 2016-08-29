require 'rails_helper'

RSpec.describe "active_members/index", type: :view do
  before(:each) do
    assign(:active_members, [
      ActiveMember.create!(
        :forename => "Forename",
        :surname => "Surname",
        :role => "Role"
      ),
      ActiveMember.create!(
        :forename => "Forename",
        :surname => "Surname",
        :role => "Role"
      )
    ])
  end

  it "renders a list of active_members" do
    render
    assert_select "tr>td", :text => "Forename".to_s, :count => 2
    assert_select "tr>td", :text => "Surname".to_s, :count => 2
    assert_select "tr>td", :text => "Role".to_s, :count => 2
  end
end
