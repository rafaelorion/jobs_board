class Job < ActiveRecord::Base
	has_many :comments
	belongs_to :company 
	scope :most_recent, -> { order("created_at DESC") }
	validates_presence_of :description, :title, :company_id

	def to_param
		"#{id}-#{title}"
	end

	def self.find_by_slug(slug)
		result = find(slug)

		if(result.to_param == slug)
			result
		else
			raise ActiveRecord::RecordNotFound
		end
	end
end
