require 'rails_helper'

RSpec.describe "active_members/edit", type: :view do
  before(:each) do
    @active_member = assign(:active_member, ActiveMember.create!(
      :forename => "MyString",
      :surname => "MyString",
      :role => "MyString"
    ))
  end

  it "renders the edit active_member form" do
    render

    assert_select "form[action=?][method=?]", active_member_path(@active_member), "post" do

      assert_select "input#active_member_forename[name=?]", "active_member[forename]"

      assert_select "input#active_member_surname[name=?]", "active_member[surname]"

      assert_select "input#active_member_role[name=?]", "active_member[role]"
    end
  end
end
