require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :title => "Title",
      :event_type => "Event Type",
      :active_members => "Active Members",
      :description => "MyText",
      :facebook_identifier => "Facebook Identifier",
      :locked => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Event Type/)
    expect(rendered).to match(/Active Members/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Facebook Identifier/)
    expect(rendered).to match(/false/)
  end
end
