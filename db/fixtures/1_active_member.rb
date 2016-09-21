require 'json'
require 'date'

@end_point = 'mitwirkende'
@base_url = 'http://lucid-berlin.de/web_developement/05_die_offene_gesellschaft_dog.lucid.berlin'

# set to true is resource should be the web; false will use the legacy/files
if true
  address = "#{@base_url}/data/#{@end_point}/json"
  json_resource = Net::HTTP.get(URI(address))
else
  json_resource = File.read("#{Rails.root}/db/fixtures/legacy/#{@end_point}.json")
end

parsed_json = JSON.load(json_resource)
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
