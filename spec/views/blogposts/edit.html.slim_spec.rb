require 'rails_helper'

RSpec.describe "blogposts/edit", type: :view do
  before(:each) do
    @blogpost = assign(:blogpost, Blogpost.create!(
      :title => "MyString",
      :blogpost_type => "MyString",
      :introduction => "MyText",
      :content => "MyText"
    ))
  end

  it "renders the edit blogpost form" do
    render

    assert_select "form[action=?][method=?]", blogpost_path(@blogpost), "post" do

      assert_select "input#blogpost_title[name=?]", "blogpost[title]"

      assert_select "input#blogpost_blogpost_type[name=?]", "blogpost[blogpost_type]"

      assert_select "textarea#blogpost_introduction[name=?]", "blogpost[introduction]"

      assert_select "textarea#blogpost_content[name=?]", "blogpost[content]"
    end
  end
end
