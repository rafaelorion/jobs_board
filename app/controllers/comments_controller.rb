class CommentsController < ApplicationController
	def create
		@job = Job.find(params[:job_id])
		
		@comment = @job.comments.build(params[:comment].permit(:name, :body))
		

		if success = @comment.save
			CompanyMailer.new_comment(@job, @comment).deliver_now
		end

		respond_to do |format|
			format.html do 
				if success
					flash[:notice] = "Comment was created with success!"
				else
					flash[:alert] = "Please fill in all fields o create a comment."
				end

				redirect_to @job
			end
			format.js
		end
	end 

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy

		redirect_to @comment.job, notice: "Comment destroyed with success!"
	end
end