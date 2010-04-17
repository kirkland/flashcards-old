class CardSoundsController < ApplicationController
  # GET /card_sounds
  # GET /card_sounds.xml
  def index
    @card_sounds = CardSound.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @card_sounds }
    end
  end

  def show
    @card_sound = CardSound.find(params[:id])
    @sound = @card_sound.sound_data
    send_data(@sound, :type => @card_sound.content_type, :filename => @card_sound.filename, :disposition => 'inline')
  end

  # GET /card_sounds/new
  # GET /card_sounds/new.xml
  def new
    @card_sound = CardSound.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @card_sound }
    end
  end

  # GET /card_sounds/1/edit
  def edit
    @card_sound = CardSound.find(params[:id])
  end

  # POST /card_sounds
  # POST /card_sounds.xml
  def create
    @card_sound = CardSound.new(params[:card_sound])

    respond_to do |format|
      if @card_sound.save
        flash[:notice] = 'CardSound was successfully created.'
        format.html { redirect_to :action => 'index' }
        format.xml  { render :xml => @card_sound, :status => :created, :location => @card_sound }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @card_sound.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /card_sounds/1
  # PUT /card_sounds/1.xml
  def update
    @card_sound = CardSound.find(params[:id])

    respond_to do |format|
      if @card_sound.update_attributes(params[:card_sound])
        flash[:notice] = 'CardSound was successfully updated.'
        format.html { redirect_to(@card_sound) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @card_sound.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /card_sounds/1
  # DELETE /card_sounds/1.xml
  def destroy
    @card_sound = CardSound.find(params[:id])
    @card_sound.destroy

    respond_to do |format|
      format.html { redirect_to(card_sounds_url) }
      format.xml  { head :ok }
    end
  end
end
