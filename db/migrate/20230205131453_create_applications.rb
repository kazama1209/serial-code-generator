class CreateApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :applications do |t|
      t.bigint :campaign_id, null: false
      t.bigint :serial_code_id, null: false
      t.bigint :venue_id, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone_number, null: false
      t.integer :gender, null: false, default: 0
      t.date :birthdate, null: false
      t.string :postal_code, null: false
      t.bigint :prefecture_id, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :building

      t.timestamps

      t.index [:campaign_id, :serial_code_id], unique: true
    end
  end
end
