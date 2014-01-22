class Timeline
  attr_reader :trip
  include ActiveModel::Model

  def initialize(trip_id)
    @trip = Trip.find(trip_id)
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
      date: [
	{
	  startDate:"2011,12,10",
	  endDate:"2011,12,11",
	  headline:"Headline Goes Here",
	  text:"<p>Body text goes here, some HTML is OK</p>",
	  tag:"This is Optional",
	  asset: {
	    media:"http://twitter.com/ArjunaSoriano/status/164181156147900416",
	    thumbnail:"optional-32x32px.jpg",
	    credit:"Credit Name Goes Here",
	    caption:"Caption text goes here"
	  }
	}
      ],
      era: [
	{
	  startDate:"2011,1,10",
	  endDate:"2011,1,11",
	  headline:"Headline Goes Here",
	  tag:"This is Optional"
	}

      ],
      chart: [
	{
	  startDate:"2011,12,10",
	  endDate:"2011,12,11",
	  headline:"Headline Goes Here",
	  value:"28"
	}

      ]

    }
  }.to_json
  end
end
