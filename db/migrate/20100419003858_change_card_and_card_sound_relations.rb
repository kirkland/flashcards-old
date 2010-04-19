class ChangeCardAndCardSoundRelations < ActiveRecord::Migration
  def self.up
    add_column :cards, :card_sound_id, :integer
    remove_column :card_sounds, :card_id
  end

  def self.down
    remove_column :cards, :card_sound_id
    add_column :card_sounds, :card_id, :integer
  end
end
