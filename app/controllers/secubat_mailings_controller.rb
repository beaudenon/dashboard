class SecubatMailingsController < ApplicationController
  # GET /secubat_mailings
  # GET /secubat_mailings.json
  def index
    @secubat_mailings = SecubatMailing.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @secubat_mailings }
    end
  end

  # GET /secubat_mailings/1
  # GET /secubat_mailings/1.json
  def show
    @secubat_mailing = SecubatMailing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @secubat_mailing }
    end
  end

  # GET /secubat_mailings/new
  # GET /secubat_mailings/new.json
  def new
    @secubat_mailing = SecubatMailing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @secubat_mailing }
    end
  end

  # GET /secubat_mailings/1/edit
  def edit
    @secubat_mailing = SecubatMailing.find(params[:id])
  end

  # POST /secubat_mailings
  # POST /secubat_mailings.json
  def create
    @secubat_mailing = SecubatMailing.new(params[:secubat_mailer])

    respond_to do |format|
      if @secubat_mailing.save
        format.html { redirect_to @secubat_mailing, notice: 'Secubat mailing was successfully created.' }
        format.json { render json: @secubat_mailing, status: :created, location: @secubat_mailing }
      else
        format.html { render action: "new" }
        format.json { render json: @secubat_mailing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /secubat_mailings/1
  # PUT /secubat_mailings/1.json
  def update
    @secubat_mailing = SecubatMailing.find(params[:id])

    respond_to do |format|
      if @secubat_mailing.update_attributes(params[:secubat_mailer])
        format.html { redirect_to @secubat_mailing, notice: 'Secubat mailing was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @secubat_mailing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secubat_mailings/1
  # DELETE /secubat_mailings/1.json
  def destroy
    @secubat_mailing = SecubatMailing.find(params[:id])
    @secubat_mailing.destroy

    respond_to do |format|
      format.html { redirect_to secubat_mailings_url }
      format.json { head :ok }
    end
  end
end
