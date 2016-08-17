require 'rails_helper'

RSpec.describe "venues/show", type: :view do
  before(:each) do
    @venue = assign(:venue, Venue.create!(
      :name => "Name",
      :street => "Street",
      :zip_code => "Zip Code",
      :city => "City",
      :description => "MyText",
      :locked => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Street/)
    expect(rendered).to match(/Zip Code/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
  end
end
