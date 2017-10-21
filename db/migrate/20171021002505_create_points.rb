class CreatePoints < ActiveRecord::Migration[5.1]
  def change
    create_table :points, id: :uuid do |t|
      t.st_point :coordinates, geographic: true
      t.uuid :resource_id
      t.string :resource_type
      t.string :address_line_1
      t.string :address_line_2
      t.string :suburb
      t.string :city
      t.string :country
      t.string :zip

      t.timestamps
    end

    add_index :points, %i[resource_id resource_type], unique: true
    add_index :points, :coordinates, using: :gist
  end
end
