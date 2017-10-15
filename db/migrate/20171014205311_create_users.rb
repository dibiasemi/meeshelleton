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

