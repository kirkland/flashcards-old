class Deck < ActiveRecord::Base
  has_many :cards, :dependent => :destroy
  belongs_to :user
  after_update :save_cards
  validates_associated :cards
  validates_length_of :name, :within => 1..30, :too_long => "Deck name must be 30 or fewer letters.", :too_short => "Deck name cannot be blank."

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
