require 'json'
require 'date'
require 'uri'

@end_point = 'veranstaltung_doku_media'

def get_file_name_from_fid(fid)
  address = 'http://die-offene-gesellschaft.de/data/fileid/json'
  json_resource = Net::HTTP.get(URI(address))
  parsed_json = JSON.load(json_resource)
  parsed_json['content']
end

# set to true is resource should be the web; false will use the legacy/files
if true
  address = "http://die-offene-gesellschaft.de/data/#{@end_point}/json"
  json_resource = Net::HTTP.get(URI(address))
else
  json_resource = File.read("#{Rails.root}/db/fixtures/legacy/#{@end_point}.json")
end

parsed_json = JSON.load(json_resource)
parsed_json['content'].each do |id, picture|
  ap "processing id #{id}"

  # get related event ID
  event_id = nil
  if picture['field_veranstaltung'].any?
    event_id = picture['field_veranstaltung']['und'][0]['target_id'].to_i * (-1)
  end
  event_record = Event.find_by(id: event_id)
  if event_id.nil? || event_record.nil?
    ap 'event record not recognized!'
    next
  end

  # description / source
  description = nil
  if picture['field_veranstaltung_doku_quelle'].any?
    description = picture['field_veranstaltung_doku_quelle']['und'][0]['value']
  end

  # created_at
  date = Time.at(user['created'].to_i).to_datetime

  # image
  picture_file = nil
  if event['field_veranstaltung_doku_media'].any?
    fid = event['field_veranstaltung_doku_media']['und'][0]['fid']
    file_name = get_file_name_from_fid(fid)
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
      ap "image '#{file_name}' can't be downloaded"
      ap escaped_file_path
      next
    end
  end
  if picture_file.nil?
    ap 'no image file!'
    next
  end

  data = {
    description: description,
    taken_at: nil,
    locked: false,
    created_at: date,
    picture: picture_file,
    event_id: event_id,
    user_id: nil
  }

  Pictures.seed(:id, data)
end
