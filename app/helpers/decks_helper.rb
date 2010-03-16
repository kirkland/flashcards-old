module DecksHelper
  def add_card_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :cards, :partial => 'card', :object => Card.new  
    end
  end
end
