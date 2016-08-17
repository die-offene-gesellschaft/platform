require 'rails_helper'

RSpec.describe "venues/index", type: :view do
  before(:each) do
    assign(:venues, [
      Venue.create!(
        :name => "Name",
        :street => "Street",
        :zip_code => "Zip Code",
        :city => "City",
        :description => "MyText",
        :locked => false
      ),
      Venue.create!(
        :name => "Name",
        :street => "Street",
        :zip_code => "Zip Code",
        :city => "City",
        :description => "MyText",
        :locked => false
      )
    ])
  end

  it "renders a list of venues" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Street".to_s, :count => 2
    assert_select "tr>td", :text => "Zip Code".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
