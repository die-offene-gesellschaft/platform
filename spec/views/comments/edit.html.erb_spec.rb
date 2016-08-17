require 'rails_helper'

RSpec.describe "comments/edit", type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      :message => "MyText",
      :locked => false
    ))
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do

      assert_select "textarea#comment_message[name=?]", "comment[message]"

      assert_select "input#comment_locked[name=?]", "comment[locked]"
    end
  end
end
