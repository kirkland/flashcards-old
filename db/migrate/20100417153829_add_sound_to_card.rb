class AddSoundToCard < ActiveRecord::Migration
  def self.up
    add_column :cards, :sound_file, :binary
  end

  def self.down
    remove_column :cards, :sound_file
  end
end
