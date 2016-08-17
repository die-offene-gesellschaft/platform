require 'rails_helper'

RSpec.describe "locations/index", type: :view do
  before(:each) do
    assign(:locations, [
      Location.create!(
        :latitude => "9.99",
        :longitude => "9.99",
        :radius => "9.99"
      ),
      Location.create!(
        :latitude => "9.99",
        :longitude => "9.99",
        :radius => "9.99"
      )
    ])
  end

  it "renders a list of locations" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
