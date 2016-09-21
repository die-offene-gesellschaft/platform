require 'json'
require 'date'
require 'uri'

@end_point = 'veranstaltung'

def create_venue_from_event(event)
  city = event['field_veranstaltung_city']['und'][0]
  data = {
    name: event['field_veranstaltung_location']['und'][0]['value'],
    street: nil,
    zip_code: city['postal_code'],
    city: city['locality'],
    description: nil,
    locked: false,
    location_id: nil
  }

  Venue.seed(:id, :name, data)[0]
end

# set to true is resource should be the web; false will use the legacy/files
if true
  address = "http://die-offene-gesellschaft.de/data/#{@end_point}/json"
  json_resource = Net::HTTP.get(URI(address))
else
  json_resource = File.read("#{Rails.root}/db/fixtures/legacy/#{@end_point}.json")
end

parsed_json = JSON.load(json_resource)
parsed_json['content'].each do |id, event|
  puts "processing id #{id}"

  if event['field_veranstaltung_date'].any?
    begin_date_time = DateTime.parse(event['field_veranstaltung_date']['und'][0]['value'])
    end_date_time = begin_date_time + 2.hours
    planned = false
  else
    begin_date_time = nil
    end_date_time = nil
    planned = true
  end

  if event['field_veranstaltung_link'].any?
    link = event['field_veranstaltung_link']['und'][0]['url']
  else
    link = nil
  end

  if event['body'].any?
    description = event['body']['und'][0]['value']
  else
    description = nil
  end

  venue = create_venue_from_event(event)

  # active members
  active_members = []
  event['field_veranstaltung_mitwirkende']['und'].each do |active_member|
    member_id = active_member['target_id'].to_i * (-1)
    active_member_record = ActiveMember.find_by(id: member_id)
    active_members << active_member_record if active_member_record
  end if event['field_veranstaltung_mitwirkende'].any?

  # image
  picture_file = nil
  if event['field_veranstaltung_img'].any?
    file_name = event['field_veranstaltung_img']['und'][0]['filename']
    file_path = "http://die-offene-gesellschaft.de/sites/default/files/#{file_name}"
    escaped_file_path = URI.escape(file_path)
    net_response = Net::HTTP.get_response(URI(escaped_file_path))

    case net_response
    when Net::HTTPSuccess
      local_file_path = Rails.root.join('public', 'fixture_download', file_name)
      File.open(local_file_path, 'wb') do |file|
        file.write(net_response.body)
      end
      picture_file = File.new(local_file_path)
    else
      puts "image '#{file_name}' can't be downloaded"
      puts escaped_file_path
    end
  end

  data = {
    id: (id.to_i * (-1)),
    title: "#{venue.name} #{venue.city}",
    event_type: 'debate',
    begin_at: begin_date_time,
    end_at: end_date_time,
    link: link,
    description: description,
    facebook_identifier: nil,
    locked: false,
    created_at: Time.at(event['created'].to_i).to_datetime,
    picture: picture_file,
    user_id: nil,
    venue_id: venue.id,
    active_members: active_members,
    planned: planned
  }

  Event.seed(:id, data)
end
