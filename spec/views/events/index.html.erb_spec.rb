require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        :title => "Title",
        :event_type => "Event Type",
        :active_members => "Active Members",
        :description => "MyText",
        :facebook_identifier => "Facebook Identifier",
        :locked => false
      ),
      Event.create!(
        :title => "Title",
        :event_type => "Event Type",
        :active_members => "Active Members",
        :description => "MyText",
        :facebook_identifier => "Facebook Identifier",
        :locked => false
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Event Type".to_s, :count => 2
    assert_select "tr>td", :text => "Active Members".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Facebook Identifier".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
