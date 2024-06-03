class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.references :inn_room, null: false, foreign_key: true
      t.references :inn, null: false, foreign_key: true
      t.integer :discount_percentage

      t.timestamps
    end
  end
end
