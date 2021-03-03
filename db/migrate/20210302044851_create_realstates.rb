class CreateRealstates < ActiveRecord::Migration[6.0]
  def change
    create_table :realstates do |t|
      t.string :name, null: false, limit: 128
      t.integer :category, null: false, default: 0
      t.string :street, limit: 128
      t.string :external_number, null: false, limit: 12
      t.string :internal_number
      t.string :neighborhood, null: false, limit: 128
      t.string :city, null: false, limit: 64
      t.string :country, null: false
      t.integer :rooms, null: false
      t.decimal :bathrooms, null: false, scale: 2, precision: 5, default: 0.0
      t.string :comments, limit: 128

      t.timestamps
    end
  end
end
