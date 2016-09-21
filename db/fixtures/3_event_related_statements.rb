require 'json'
require 'date'
require 'uri'

@end_point = 'veranstaltung_doku_text'
@base_url = 'http://lucid-berlin.de/web_developement/05_die_offene_gesellschaft_dog.lucid.berlin'

# set to true is resource should be the web; false will use the legacy/files
if false
  address = "#{@base_url}/data/#{@end_point}/json"
  json_resource = Net::HTTP.get(URI(address))
else
  json_resource = File.read("#{Rails.root}/db/fixtures/legacy/#{@end_point}.json")
end

parsed_json = JSON.load(json_resource)
parsed_json['content'].each do |id, event|
  puts "processing id #{id}"

  # get related event ID
  event_id = nil
  if event['field_veranstaltung'].any?
    event_id = event['field_veranstaltung']['und'][0]['target_id'].to_i * (-1)
  end
  event_record = Event.find_by(id: event_id)
  if event_id.nil? || event_record.nil?
    puts 'event record not recognized!'
    next
  end

  # statement
  statement = nil
  if event['body'].any?
    statement = event['body']['und'][0]['value']
  end
  if statement.nil?
    puts 'no statement!'
    next
  end

  # source / author
  author = nil
  if event['field_veranstaltung_doku_quelle'].any?
    author = event['field_veranstaltung_doku_quelle']['und'][0]['value']
  end

  # created_at
  date = Time.at(event['created'].to_i).to_datetime

  data = {
    id: (id.to_i * (-1)),
    question: nil,
    content: statement,
    author: author,
    created_at: date,
    event_id: event_id
  }

  Statement.seed(:id, data)
end
