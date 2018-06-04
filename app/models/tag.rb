# Helper class that maintains static variables tied to the tagging system.

class Tag
  attr_accessor :COLORS
	attr_accessor :TAG_TYPES

  def self.instance
    @@instance ||= new
  end

	# Add new tags here
  def initialize
		@TAG_TYPES = Array.new ['Abroad', 'English', 'Spanish', "Unpaid"].freeze
		setup_colors
  end
  
  # Helper function to get the corresponding color
  def get_color(tag)
  	return @COLORS[tag]
  end
  
  # Called upon initialization.
  # Colors are portioned out of the color wheel
  private
  	def setup_colors 
			@COLORS = Hash.new
	
			# Generates a color for each tag type
			y = 0.2
			darken = 0.7
			portion = 2.0 / @TAG_TYPES.length * Math::PI
			
			@TAG_TYPES.each_with_index do |tag, index|
				index += 0.5
				
				# Using the YUV color model
				v = Math.sin(portion * index)
				u = Math.cos(portion * index)
				
				r=(darken * 255 * (y+v/0.88)).round.to_s
				g=(darken * 255 * (y-0.38*u-0.58*v)).round.to_s
				b=(darken * 255 * (y+u/0.49)).round.to_s
				
				@COLORS[tag] = ("rgb(" + r + "," + g + "," + b + ")")
		end
	end
end