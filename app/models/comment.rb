class Comment < ActiveRecord::Base
	belongs_to :job, counter_cache: true
	validates_presence_of :name, :body, :job_id
end
