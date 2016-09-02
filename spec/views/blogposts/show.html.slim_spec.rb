require 'rails_helper'

RSpec.describe "blogposts/show", type: :view do
  before(:each) do
    @blogpost = assign(:blogpost, Blogpost.create!(
      :title => "Title",
      :blogpost_type => "Blogpost Type",
      :introduction => "MyText",
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Blogpost Type/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
