class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.string :title
      t.string :owner
      t.string :city
      t.string :type
      t.string :image
      t.integer :bedrooms
      t.string :description

      t.timestamps
    end
  end
end
