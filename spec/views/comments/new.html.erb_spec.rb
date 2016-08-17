require 'rails_helper'

RSpec.describe "comments/new", type: :view do
  before(:each) do
    assign(:comment, Comment.new(
      :message => "MyText",
      :locked => false
    ))
  end

  it "renders new comment form" do
    render

    assert_select "form[action=?][method=?]", comments_path, "post" do

      assert_select "textarea#comment_message[name=?]", "comment[message]"

      assert_select "input#comment_locked[name=?]", "comment[locked]"
    end
  end
end
