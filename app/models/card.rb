class Card < ActiveRecord::Base
  belongs_to :deck
  attr_accessor :should_destroy
  has_one :card_sound

  def should_destroy?
    should_destroy.to_i == 1
  end
end
