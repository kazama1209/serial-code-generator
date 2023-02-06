class CreateSerialCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :serial_codes do |t|
      t.bigint :campaign_id, null: false
      t.string :value, null: false
      t.integer :status, null: false, default: 0
      t.date :expired_at, null: false

      t.timestamps

      t.index [:value]
      t.index [:campaign_id, :value], unique: true
    end
  end
end
