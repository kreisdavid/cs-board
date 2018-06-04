# Helper class that maintains static variables tied to the tagging system.

class Offer
  attr_accessor :OFFER_TYPES

  def self.instance
    @@instance ||= new
  end

	# Add new offers here
  def initialize
		@OFFER_TYPES = Array.new ['Internship', 'Volunteer', 'Part-Time', "Full-Time"].freeze
  end
  
  # Returns the offer types the format required for a drop-down
  def get_select_format
  	return @OFFER_TYPES.map{|v| [v,v]}
  end
end