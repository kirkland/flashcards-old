class DecksController < ApplicationController
  before_filter :is_owner?, :except => [:index, :show, :new, :create]

  def index
    @decks = Deck.find(:all, :conditions => { :user_id => current_user.id })
  end

  def show
    @deck = Deck.find(params[:id])
  end

  def new
    @deck = Deck.new
    3.times { @deck.cards.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deck }
    end
  end

  def edit
    @deck = Deck.find(params[:id])
  end

  def create
    @deck = Deck.new(params[:deck])
    @deck.user_id = current_user.id

    respond_to do |format|
      # remove cards where both sides are blank
      @deck.cards = @deck.cards.delete_if { |card|
        card.front == "" && card.back == ""
      }

      if @deck.save
        flash[:notice] = 'Deck was successfully created.'
        format.html { redirect_to(@deck) }
        format.xml  { render :xml => @deck, :status => :created, :location => @deck }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @deck.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @deck = Deck.find(params[:id])

    respond_to do |format|
      # remove cards where both sides are blank
      unless params[:deck][:card_attributes].nil?
        params[:deck][:card_attributes].delete_if { |card|
          card[:front] == "" && card[:back] == ""
        }
      end

      if @deck.update_attributes(params[:deck])
        flash[:notice] = 'Deck was successfully updated.'
        format.html { redirect_to(@deck) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deck.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @deck = Deck.find(params[:id])
    @deck.destroy

    respond_to do |format|
      format.html { redirect_to(decks_url) }
      format.xml  { head :ok }
    end
  end
  
  def is_owner?
    if Deck.find(params[:id]).user_id != current_user.id
      flash[:notice] = "Not Authorized"
      redirect_to :decks
    end
  end
end
