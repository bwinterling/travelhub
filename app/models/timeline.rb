class Timeline
  attr_reader :trip
  include ActiveModel::Model

  def initialize(trip_id)
    @trip = Trip.find(trip_id)
  end

  def photos_array
    trip.photos.empty? ? [] : trip.photos.map { |photo| photo.timeline_hash }
  end

  def statuses_array
    trip.statuses.empty? ? [] : trip.statuses.map { |status| status.timeline_hash }
  end

  def date_array
    photos_array + statuses_array
  end

  def return_json
    {
      timeline:
      {
        headline: "Timeline for #{trip.name}",
        type:"default",
        text:"<p>#{trip.description}</p>",
        asset: {
          media:"http://www.jaunted.com/files/6193/the_griswalds.jpg",
          credit:"jaunted.com",
          caption:"Hi Aunt Edna!"
        },
        date: date_array
      }
    }.to_json
  end
end
