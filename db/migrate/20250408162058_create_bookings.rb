class CreateBookings < ActiveRecord::Migration[7.2]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.integer :status, :default => 0
      t.boolean :approved, default: false
      t.decimal :total_price
      t.decimal :refunded_price

      t.timestamps
    end
  end
end
