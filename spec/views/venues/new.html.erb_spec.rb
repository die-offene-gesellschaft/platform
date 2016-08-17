require 'rails_helper'

RSpec.describe "venues/new", type: :view do
  before(:each) do
    assign(:venue, Venue.new(
      :name => "MyString",
      :street => "MyString",
      :zip_code => "MyString",
      :city => "MyString",
      :description => "MyText",
      :locked => false
    ))
  end

  it "renders new venue form" do
    render

    assert_select "form[action=?][method=?]", venues_path, "post" do

      assert_select "input#venue_name[name=?]", "venue[name]"

      assert_select "input#venue_street[name=?]", "venue[street]"

      assert_select "input#venue_zip_code[name=?]", "venue[zip_code]"

      assert_select "input#venue_city[name=?]", "venue[city]"

      assert_select "textarea#venue_description[name=?]", "venue[description]"

      assert_select "input#venue_locked[name=?]", "venue[locked]"
    end
  end
end
