venues_to_delete = []

Venue.group(:name).each do |venue|
  same_named_venues = Venue.where(name: venue.name)
  if same_named_venues.count > 1
    same_named_venues.each_with_index do |doubled_venue, index|
      if index > 0
        doubled_venue.events.each do |related_event|
          ap "changing venue of event title: #{related_event.title}"
          related_event.venue = same_named_venues[0]
          unless related_event.validate
            related_event.begin_at = Time.zone.now unless related_event.begin_at
            related_event.end_at = Time.zone.now + 2.hours unless related_event.end_at
            related_event.description = related_event.title unless related_event.description
          end
          related_event.save!
        end
        venues_to_delete << doubled_venue.id
      end
    end
  end
end

care_for_venues = []

venues_to_delete.each do |venue_id|
  venue = Venue.find(venue_id)
  care_for_venues << venue_id if venue.events.any?
  venue.destroy if venue.events.empty?
end

ap care_for_venues
