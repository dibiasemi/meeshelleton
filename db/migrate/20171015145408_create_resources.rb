class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string :name, null: false
      t.string :description, null: false
      #t.referenes :user is an alternative to below:
      t.references :user

      t.timestamps
    end
  end
end
