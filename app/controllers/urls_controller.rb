class UrlsController < ApplicationController
  layout "empty"
  # GET /urls
  # GET /urls.json
  def index
    @urls = Url.all(:order => ["id DESC"])
    @count_urls = Url.count()
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @urls }
    end
  end

  # GET /urls/1
  # GET /urls/1.json
  def show
    @url = Url.find(params[:id])
    @count_urls = Url.count()

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @url }
    end
  end

  # GET /urls/new
  # GET /urls/new.json
  def new
    @url = Url.new
    @count_urls = Url.count()

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @url }
    end
  end

  # GET /urls/1/edit
  def edit
    @url = Url.find(params[:id])
    @count_urls = Url.count()

  end

  # POST /urls
  # POST /urls.json
  def create
    @url = Url.new(params[:url])
    @count_urls = Url.count()

    respond_to do |format|
      if @url.save
        if params["commit"] == "Save and Insert"
          format.html { redirect_to new_url_path, notice: 'Url was successfully created.' }
        else
          format.html { redirect_to @url, notice: 'Url was successfully created.' }
          format.json { render json: @url, status: :created, location: @url }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /urls/1
  # PUT /urls/1.json
  def update
    @url = Url.find(params[:id])
    @count_urls = Url.count()

    respond_to do |format|
      if @url.update_attributes(params[:url])
        format.html { redirect_to @url, notice: 'Url was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /urls/1
  # DELETE /urls/1.json
  def destroy
    @url = Url.find(params[:id])
    @url.destroy

    respond_to do |format|
      format.html { redirect_to urls_url }
      format.json { head :ok }
    end
  end
end
