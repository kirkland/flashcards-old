class User < ActiveRecord::Base
  acts_as_authentic
  has_many :decks, :dependent => :destroy
end
