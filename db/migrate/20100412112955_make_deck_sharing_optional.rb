class MakeDeckSharingOptional < ActiveRecord::Migration
  def self.up
    add_column :decks, :share, :boolean, :default => 0, :nullable => false
    Deck.find(:all).each do |deck|
      deck.update_attribute :share, 0
    end
  end

  def self.down
    remove_column :decks, :share
  end
end
