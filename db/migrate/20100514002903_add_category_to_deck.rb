class AddCategoryToDeck < ActiveRecord::Migration
  def self.up
    add_column :decks, :category, :string
  end

  def self.down
    remove_column :decks, :category
  end
end
