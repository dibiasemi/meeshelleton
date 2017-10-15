class CreateUsers < ActiveRecord::Migration[5.0]
  def change
     create_table :users do |t|
      t.string :name, null: false
      t.string :username, null: false
      t.string :email, null: false
      #This will eventually be the encrypted password given to us by Bcrypt *magic*
      t.string :encrypted_password, null: false

      t.timestamps
    end

  end
end


# Example of how to create another table:
# def change
#     create_table :games do |t|
#       t.string :name, null: false
#       t.string :description, null: false
#       #t.referenes :user is an alternative to below:
#       t.references :user

#       t.timestamps
# end