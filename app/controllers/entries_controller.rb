class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /entries
  # GET /entries.json
  def index
    @tasks = Highrise::Task.find(:all)
    @entries = Entry.all
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
    @contacts = Highrise::Person.find(:all)
    @cases = Highrise::Kase.find(:all)
    @tags = Highrise::Tag.find(:all)

  end

  # GET /entries/1/edit
  def edit
    @cases = Highrise::Kase.find(:all)
    @contacts = Highrise::Person.find(:all)
    @cases = Highrise::Kase.find(:all)
    @tags = Highrise::Tag.find(:all)
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)
    @entry.contacts = params["contacts"]
    @entry.tags = params["tags"]
    @entry.cases = params["cases"]
    
    if !@entry.contacts.nil?
      n = Highrise::Note.new(:body=>@entry.entry_text,"subject-type"=>"Party","subject-id"=>@entry.contacts.to_i)
      n.save
    end

    if !@entry.cases.nil?
      n = Highrise::Note.new(:body=>@entry.entry_text,"subject-type"=>"Kase","subject-id"=>@entry.cases.to_i)
      n.save
    end

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update



    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:entry_text)
    end
end
