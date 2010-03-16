class Deck < ActiveRecord::Base
  has_many :cards
  after_update :save_cards

  def card_attributes=(card_attributes)
    card_attributes.each do |attributes|
      if attributes[:id].blank?
        cards.build(attributes)
      else
        card = cards.detect { |c| c.id == attributes[:id].to_i }
        card.attributes = attributes
      end
    end
  end

  def save_cards
    cards.each do |c|
      if c.should_destroy?
        c.destroy
      else
        c.save(false)        
      end
    end
  end
end
