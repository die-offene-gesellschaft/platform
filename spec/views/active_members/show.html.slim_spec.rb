require 'rails_helper'

RSpec.describe "active_members/show", type: :view do
  before(:each) do
    @active_member = assign(:active_member, ActiveMember.create!(
      :forename => "Forename",
      :surname => "Surname",
      :role => "Role"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Forename/)
    expect(rendered).to match(/Surname/)
    expect(rendered).to match(/Role/)
  end
end
