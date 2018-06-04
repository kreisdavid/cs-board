class Post < ActiveRecord::Base
  scope :approved, lambda {|approved| {:conditions => {:approved => approved}}}
	validates_presence_of :title, :description, :expire_date, :offer_type, :location
  serialize :tag_list

	# Is post saved by current user?
	def is_saved(user_id)
		User.find(user_id).posts.include? self
	end

	# Archive if expired
	def archive
		self.archived = true if Time.now > self.expire_date
	end

  # Return string of tags separated by commas
  def get_comma_separated_tags
  	return tag_list.join(", ")
  end

  def self.ransackable_attributes auth_object = nil
    ["title", "description", "expire_date", "expire_time", "offer_type", "location", "tag_list"]
  end

  def post_index_title
    self.offer_type + " - " + self.title
  end
end
