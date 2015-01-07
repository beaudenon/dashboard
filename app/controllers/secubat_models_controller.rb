class SecubatModelsController < ApplicationController
  # GET /secubat_models
  # GET /secubat_models.json
  def index
    @secubat_models = SecubatModel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @secubat_models }
    end
  end

  # GET /secubat_models/1
  # GET /secubat_models/1.json
  def show
    @secubat_model = SecubatModel.find(params[:id])

    @secubat_mailings = SecubatMailing.order("secubat_mailings.created_at DESC").all(:include => :secubat_model, :joins => :secubat_client, :conditions => {:secubat_model_id => @secubat_model})

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @secubat_model }
    end
  end

  # GET /secubat_models/new
  # GET /secubat_models/new.json
  def new
    @secubat_model = SecubatModel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @secubat_model }
    end
  end

  # GET /secubat_models/1/edit
  def edit
    @secubat_model = SecubatModel.find(params[:id])
  end

  # POST /secubat_models
  # POST /secubat_models.json
  def create
    @secubat_model = SecubatModel.new(params[:secubat_model])

    respond_to do |format|
      if @secubat_model.save
        format.html { redirect_to @secubat_model, notice: 'Secubat model was successfully created.' }
        format.json { render json: @secubat_model, status: :created, location: @secubat_model }
      else
        format.html { render action: "new" }
        format.json { render json: @secubat_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /secubat_models/1
  # PUT /secubat_models/1.json
  def update
    @secubat_model = SecubatModel.find(params[:id])

    respond_to do |format|
      if @secubat_model.update_attributes(params[:secubat_model])
        format.html { redirect_to @secubat_model, notice: 'Secubat model was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @secubat_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secubat_models/1
  # DELETE /secubat_models/1.json
  def destroy
    @secubat_model = SecubatModel.find(params[:id])
    @secubat_model.destroy

    respond_to do |format|
      format.html { redirect_to secubat_models_url }
      format.json { head :ok }
    end
  end
end
