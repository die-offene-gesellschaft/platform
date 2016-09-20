# require 'open-uri'
require 'json'
require 'date'
require 'uri'

# resource = open('http://die-offene-gesellschaft.de/data/profil/json')
resource = File.read("#{Rails.root}/db/fixtures/legacy/profil.json")
parsed_json = JSON.load(resource)

parsed_json['content'].each do |id, user|
  ap "processing id #{id}"

  date = Time.at(user['created'].to_i).to_datetime
  name = user['field_vorname']['und'][0]['value']
  name = "#{name} #{user['title']}"
  email = user['field_profil_email']['und'][0]['email']
  next if User.find_by(email: email)

  # image
  if user['field_veranstaltung_img'].any?
    file_name = user['field_veranstaltung_img']['und'][0]['filename']
    file_path = "http://die-offene-gesellschaft.de/sites/default/files/#{file_name}"
    escaped_file_path = URI.escape(file_path)
    local_file_path = Rails.root.join('public', 'fixture_download', file_name)
    net_response = Net::HTTP.get(URI(escaped_file_path))

    File.open(local_file_path, 'wb') do |file|
      file.write(net_response)
    end
    avatar_file = File.new(local_file_path)
  else
    avatar_file = nil
  end

  data = {
    id: (id.to_i * (-1)),
    email: email,
    created_at: date,
    avatar: avatar_file,
    role: user['field_beschreibung']['und'][0]['value'],
    statement: user['field_kurzstatement']['und'][0]['value'],
    locked: false,
    name: name
  }

  User.seed(:id, :email, data)
end
