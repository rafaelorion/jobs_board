class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :email
      t.string :encrypted_password

      t.timestamps null: false
    end
  end
end
