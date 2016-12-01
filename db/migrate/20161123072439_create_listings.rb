class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
    	t.integer :user_id
    	t.string :address
    	t.string :price
    	t.string :description
    	t.string :name
      t.timestamps null: false
    end
  end
end
