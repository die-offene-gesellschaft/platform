require 'rails_helper'

RSpec.describe "blogposts/new", type: :view do
  before(:each) do
    assign(:blogpost, Blogpost.new(
      :title => "MyString",
      :blogpost_type => "MyString",
      :introduction => "MyText",
      :content => "MyText"
    ))
  end

  it "renders new blogpost form" do
    render

    assert_select "form[action=?][method=?]", blogposts_path, "post" do

      assert_select "input#blogpost_title[name=?]", "blogpost[title]"

      assert_select "input#blogpost_blogpost_type[name=?]", "blogpost[blogpost_type]"

      assert_select "textarea#blogpost_introduction[name=?]", "blogpost[introduction]"

      assert_select "textarea#blogpost_content[name=?]", "blogpost[content]"
    end
  end
end
