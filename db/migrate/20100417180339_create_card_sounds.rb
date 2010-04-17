class CreateCardSounds < ActiveRecord::Migration
  def self.up
    create_table :card_sounds do |t|
      t.string :filename
      t.string :content_type
      t.binary :sound_data
      t.decimal :card_id

      t.timestamps
    end
  end

  def self.down
    drop_table :card_sounds
  end
end
