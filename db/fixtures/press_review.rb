require 'open-uri'
require 'json'

resource = open('http://die-offene-gesellschaft.de/data/medienspiegel/json/')
# resource = File.read("#{Rails.root}/db/fixtures/legacy/medienspiegel.json")
parsed_json = JSON.load(resource)

parsed_json['content'].each do |id, press_review|
  if press_review['field_medienspiegel_link'].any?
    link = press_review['field_medienspiegel_link']['und'][0]['url']
  else
    link = press_review['field_medienspiegel_source']['und'][0]['url']
  end

  date = DateTime.parse(press_review['field_medienspiegel_date']['und'][0]['value'])

  data = {
    id: (id.to_i * (-1)),
    source_url: press_review['field_medienspiegel_source']['und'][0]['url'],
    source_title: press_review['field_medienspiegel_media_title']['und'][0]['value'],
    title: press_review['title'],
    description: press_review['body']['und'][0]['value'],
    link: link,
    created_at: date
  }

  PressReview.seed(:id, data)
end
