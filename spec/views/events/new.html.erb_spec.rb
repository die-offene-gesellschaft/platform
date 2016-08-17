require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      :title => "MyString",
      :event_type => "MyString",
      :active_members => "MyString",
      :description => "MyText",
      :facebook_identifier => "MyString",
      :locked => false
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input#event_title[name=?]", "event[title]"

      assert_select "input#event_event_type[name=?]", "event[event_type]"

      assert_select "input#event_active_members[name=?]", "event[active_members]"

      assert_select "textarea#event_description[name=?]", "event[description]"

      assert_select "input#event_facebook_identifier[name=?]", "event[facebook_identifier]"

      assert_select "input#event_locked[name=?]", "event[locked]"
    end
  end
end
