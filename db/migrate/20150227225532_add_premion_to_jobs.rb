class AddPremionToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :premium, :boolean
  end
end
