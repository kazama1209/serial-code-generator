class CreateVenues < ActiveRecord::Migration[6.1]
  def change
    create_table :venues do |t|
      t.bigint :campaign_id, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
