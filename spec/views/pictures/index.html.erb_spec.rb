require 'rails_helper'

RSpec.describe "pictures/index", type: :view do
  before(:each) do
    assign(:pictures, [
      Picture.create!(
        :description => "MyText",
        :locked => false
      ),
      Picture.create!(
        :description => "MyText",
        :locked => false
      )
    ])
  end

  it "renders a list of pictures" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
