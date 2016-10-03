Event.where(event_type: 'debate').each do |event|
  event.event_type = 'Debatte'
  event.description = event.title if event.description.empty?
  event.save
end
