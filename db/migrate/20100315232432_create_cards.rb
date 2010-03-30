class CreateCards < ActiveRecord::Migration
  def self.up
    create_table :cards do |t|
      t.string :front
      t.string :back
      t.integer :deck_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cards
  end
end
