class Job < ActiveRecord::Base
	has_many :comments
	belongs_to :company 
	scope :most_recent, -> { order("created_at DESC") }
	validates_presence_of :description, :title, :company_id

	def to_param
		"#{id}-#{title}"
	end
end
