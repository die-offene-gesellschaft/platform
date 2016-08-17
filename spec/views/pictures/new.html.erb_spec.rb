require 'rails_helper'

RSpec.describe "pictures/new", type: :view do
  before(:each) do
    assign(:picture, Picture.new(
      :description => "MyText",
      :locked => false
    ))
  end

  it "renders new picture form" do
    render

    assert_select "form[action=?][method=?]", pictures_path, "post" do

      assert_select "textarea#picture_description[name=?]", "picture[description]"

      assert_select "input#picture_locked[name=?]", "picture[locked]"
    end
  end
end
