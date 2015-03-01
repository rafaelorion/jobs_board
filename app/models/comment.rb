class Comment < ActiveRecord::Base
	belongs_to :job
	validates_presence_of :name, :body, :job_id
end
