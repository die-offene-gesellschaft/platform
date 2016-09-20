require 'json'
require 'date'
require 'uri'

@end_point = 'veranstaltung_doku_text'

# set to true is resource should be the web; false will use the legacy/files
if true
  address = "http://die-offene-gesellschaft.de/data/#{@end_point}/json"
  json_resource = Net::HTTP.get(URI(address))
else
  json_resource = File.read("#{Rails.root}/db/fixtures/legacy/#{@end_point}.json")
end

parsed_json = JSON.load(json_resource)
parsed_json['content'].each do |id, docu_text|
  ap "processing id #{id}"

  # get related event ID
  event_record = nil
  if docu_text['field_veranstaltung'].any?
    event_id = docu_text['field_veranstaltung']['und'][0]['target_id'].to_i * (-1)
    event_record = Event.find_by(id: event_id)
  end
  if event_record.nil?
    ap 'event record not recognized!'
    next
  end

  # post_description
  if docu_text['field_veranstaltung_doku_quelle'].any?
    value = docu_text['field_veranstaltung_doku_quelle']['und'][0]['value']
    event_record.post_description_source = value
  end

  # post_description_source
  if docu_text['body'].any?
    event_record.post_description = docu_text['body']['und'][0]['value']
  else
    ap 'no description!'
    next
  end

  event_record.save!
end
