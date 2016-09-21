require 'json'
require 'date'
require 'uri'

@end_point = 'profil'

# set to true is resource should be the web; false will use the legacy/files
if true
  address = "http://lucid-berlin.de/web_developement/05_die_offene_gesellschaft_dog.lucid.berlin/data/#{@end_point}/json"
  json_resource = Net::HTTP.get(URI(address))
else
  json_resource = File.read("#{Rails.root}/db/fixtures/legacy/#{@end_point}.json")
end

parsed_json = JSON.load(json_resource)
parsed_json['content'].each do |id, user|
  puts "processing id #{id}"

  date = Time.at(user['created'].to_i).to_datetime
  name = user['field_vorname']['und'][0]['value']
  name = "#{name} #{user['title']}"
  email = user['field_profil_email']['und'][0]['email']

  # image
  avatar_file = nil
  if user['field_veranstaltung_img'].any?
    file_name = user['field_veranstaltung_img']['und'][0]['filename']
    file_path = "http://die-offene-gesellschaft.de/sites/default/files/#{file_name}"
    escaped_file_path = URI.escape(file_path)
    net_response = Net::HTTP.get_response(URI(escaped_file_path))

    case net_response
    when Net::HTTPSuccess
      local_file_path = Rails.root.join('public', 'fixture_download', file_name)
      File.open(local_file_path, 'wb') do |file|
        file.write(net_response.body)
      end
      avatar_file = File.new(local_file_path)
    else
      puts "image '#{file_name}' can't be downloaded"
      puts escaped_file_path
    end
  end

  # statement
  statement = user['field_kurzstatement']['und'][0]['value']
  statement = nil if statement == 'Kurzstatement'

  data = {
    id: (id.to_i * (-1)),
    email: email,
    created_at: date,
    avatar: avatar_file,
    role: user['field_beschreibung']['und'][0]['value'],
    statement: statement,
    locked: false,
    name: name
  }

  User.seed(:email, data) unless email == 'Prime@web.de'
end
