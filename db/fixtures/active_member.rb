require 'open-uri'
require 'json'
require 'date'

# resource = open('http://die-offene-gesellschaft.de/data/mitwirkende/json')
resource = File.read("#{Rails.root}/db/fixtures/legacy/mitwirkende.json")
parsed_json = JSON.load(resource)

parsed_json['content'].each do |id, active_member|
  if active_member['field_mitwirkende_post'].any?
    role = active_member['field_mitwirkende_post']['und'][0]['value']
  else
    role = ''
  end

  date = Time.at(active_member['created'].to_i).to_datetime

  data = {
    id: (id.to_i * (-1)),
    forename: active_member['field_mitwirkende_name']['und'][0]['value'],
    surname: active_member['field_mitwirkende_surname']['und'][0]['value'],
    role: role,
    created_at: date
  }

  ActiveMember.seed(:id, data)
end
