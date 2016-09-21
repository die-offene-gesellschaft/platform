require 'json'

@end_point = 'medienspiegel'

# set to true is resource should be the web; false will use the legacy/files
if true
  address = "http://lucid-berlin.de/web_developement/05_die_offene_gesellschaft_dog.lucid.berlin/data/#{@end_point}/json"
  json_resource = Net::HTTP.get(URI(address))
else
  json_resource = File.read("#{Rails.root}/db/fixtures/legacy/#{@end_point}.json")
end

parsed_json = JSON.load(json_resource)
parsed_json['content'].each do |id, press_review|
  if press_review['field_medienspiegel_link'].any?
    link = press_review['field_medienspiegel_link']['und'][0]['url']
  else
    link = press_review['field_medienspiegel_source']['und'][0]['url']
  end

  # related events
  related_event_id = nil
  press_review['field_veranstaltung']['und'].each do |event|
    event_id = event['target_id'].to_i * (-1)
    event_record = Event.find_by(id: event_id)
    related_event_id = event_record.id if event_record
  end if press_review['field_veranstaltung'].any?

  date = DateTime.parse(press_review['field_medienspiegel_date']['und'][0]['value'])

  data = {
    id: (id.to_i * (-1)),
    source_url: press_review['field_medienspiegel_source']['und'][0]['url'],
    source_title: press_review['field_medienspiegel_media_title']['und'][0]['value'],
    title: press_review['title'],
    description: press_review['body']['und'][0]['value'],
    link: link,
    event_id: related_event_id,
    created_at: date
  }

  PressReview.seed(:id, data)
end
