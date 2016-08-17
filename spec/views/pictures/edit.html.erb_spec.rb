require 'rails_helper'

RSpec.describe "pictures/edit", type: :view do
  before(:each) do
    @picture = assign(:picture, Picture.create!(
      :description => "MyText",
      :locked => false
    ))
  end

  it "renders the edit picture form" do
    render

    assert_select "form[action=?][method=?]", picture_path(@picture), "post" do

      assert_select "textarea#picture_description[name=?]", "picture[description]"

      assert_select "input#picture_locked[name=?]", "picture[locked]"
    end
  end
end
