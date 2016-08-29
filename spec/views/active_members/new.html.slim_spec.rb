require 'rails_helper'

RSpec.describe "active_members/new", type: :view do
  before(:each) do
    assign(:active_member, ActiveMember.new(
      :forename => "MyString",
      :surname => "MyString",
      :role => "MyString"
    ))
  end

  it "renders new active_member form" do
    render

    assert_select "form[action=?][method=?]", active_members_path, "post" do

      assert_select "input#active_member_forename[name=?]", "active_member[forename]"

      assert_select "input#active_member_surname[name=?]", "active_member[surname]"

      assert_select "input#active_member_role[name=?]", "active_member[role]"
    end
  end
end
