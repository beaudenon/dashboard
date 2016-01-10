# encoding: utf-8
class SecubatClientsController < ApplicationController
  # GET /secubat_clients
  # GET /secubat_clients.json

  before_filter :set_locale

  def index
    @secubat_clients = SecubatClient.all.order("id ASC")
    @count_secubat_clients = SecubatClient.count()
    @count_total_mailings = SecubatMailing.count()

    load_context

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @secubat_clients }
    end
  end

  def load_context
    @secubat_models = SecubatModel.all.where(:is_activated => true).order(:id)
    @secubat_count_mailings = SecubatMailing.count(:include => :secubat_model, :conditions => {:secubat_models => {:is_activated => true}}, :group => :secubat_client_id)
    @secubat_count_mailings_by_users = SecubatMailing.count(:group => [:secubat_client_id, :secubat_model_id])
    @secubat_more_recent_mailing_by_user = SecubatMailing.maximum(:updated_at, :group => :secubat_client_id)
    @count_total_mailings = SecubatMailing.count()
    @count_total_mailings_this_week_success = SecubatMailing.sent_this_week_success.count
    @count_total_mailings_this_week_pending = SecubatMailing.sent_this_week_pending.count
  end

  # GET /secubat_clients/1
  # GET /secubat_clients/1.json
  def show
    @secubat_client = SecubatClient.find(params[:id])
    @secubat_mailings = SecubatMailing.order("secubat_mailings.created_at DESC").all.includes(:secubat_model).where(:secubat_client_id => @secubat_client)
    @secubat_count_mailings = SecubatMailing.includes(:secubat_model).where(:secubat_models => {:is_activated => true}).group(:secubat_client_id).count
    @secubat_models = SecubatModel.all.where(:is_activated => true).order(:id)
    @secubat_count_mailings_by_users = SecubatMailing.count(:group => [:secubat_client_id, :secubat_model_id])
    #@secubat_mailings = SecubatMailing.order("secubat_mailings.created_at DESC").find_all_by_secubat_client_id(@secubat_client.id)
    build_navigation
    load_context
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @secubat_client }
    end
  end

  # GET /secubat_clients/new
  # GET /secubat_clients/new.json
  def new
    @secubat_client = SecubatClient.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @secubat_client }
    end
  end

  # GET /secubat_clients/1/edit
  def edit
    @secubat_client = SecubatClient.find(params[:id])
    build_navigation
  end

  # POST /secubat_clients
  # POST /secubat_clients.json
  def create
    @secubat_client = SecubatClient.new(secubat_client_params)

    respond_to do |format|
      if @secubat_client.save
        if params["commit"] == "Sauvegarder et Ajouter un nouveau client"
          format.html { redirect_to new_secubat_client_path, notice: 'Ajout du client OK.' }
        else
          format.html { redirect_to @secubat_client, notice: 'Ajout du client OK.' }
          format.json { render json: @secubat_client, status: :created, location: @secubat_client }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @secubat_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /secubat_clients/1
  # PUT /secubat_clients/1.json
  def update
    @secubat_client = SecubatClient.find(params[:id])
    build_navigation
    respond_to do |format|
      if @secubat_client.update(secubat_client_params)
        case params["commit"]
          when "Sauvegarder" then format.html { redirect_to @secubat_client, notice: 'Modification du client OK.' }
          when "Sauvegarder et Ajouter un nouveau client" then format.html {redirect_to new_secubat_client_path_path, notice: 'Modification du client OK.' }
          when "Sauvegarder et Précédent" then format.html { redirect_to edit_secubat_client_path(:id => @secubat_client_previous.id), notice: 'Modification du client précédent OK.' }
          when "Sauvegarder et Suivant" then format.html { redirect_to edit_secubat_client_path(:id => @secubat_client_next.id), notice: 'Modification du client précédent OK.' }
          else format.html { redirect_to secubat_client_path(:id => @secubat_client.id), notice: 'Modification du client OK.' }
        end
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @secubat_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secubat_clients/1
  # DELETE /secubat_clients/1.json
  def destroy
    @secubat_client = SecubatClient.find(params[:id])
    @secubat_client.destroy

    respond_to do |format|
      format.html { redirect_to secubat_clients_url }
      format.json { head :ok }
    end
  end

  # GET /secubat_clients/:id/send_mailing(.:format)
  def send_mailing
    @secubat_client = SecubatClient.find(params[:id])
    secubat_model = SecubatModel.find(4)
    @mailing = SecubatMailing.new(:secubat_model => secubat_model, :secubat_client => @secubat_client)

    @mailing.save

    @secubat_count_mailings = SecubatMailing.count(:conditions => {:secubat_client_id => @secubat_client.id}, :group => :secubat_client_id)
    @secubat_models = SecubatModel.all(:order => :id)
    @count_total_mailings = SecubatMailing.count()

    if @secubat_client.save
      SecubatMailing.send("voeux2012", @secubat_client).deliver
      #SecubatMailing.send_later("voeux2012", @secubat_client).deliver
      #Delayed::Job.enqueue MailingJob.new(@template.to_sym, @mailing, user, request.host)
    end

    respond_to do |format|
      format.js {render :index}
    end

    #@secubat_client.mailing_voeux = true
    #format.js { render :index, notice: 'Envoi de mail OK.' }
  end

  # PUT
  def send_mailing_model
    @secubat_client = SecubatClient.find(params[:id])
    secubat_model = SecubatModel.find(params[:model_id])

    #if @secubat_client.save
    #if @secubat_client.is_admin?
      @mailing = SecubatMailing.new(:secubat_model => secubat_model, :secubat_client => @secubat_client)
      @mailing.save
      #SecubatMailer.send(secubat_model.template, @secubat_client, @mailing.id, secubat_model.subject, secubat_model.body, @mailing).deliver

      Delayed::Job.enqueue MailingSecubat.new(secubat_model.template, @secubat_client, @mailing.id, secubat_model.subject, secubat_model.body, @mailing), :queue => "mailing-#{secubat_model.template}"
    #end
    #end
    load_context
    @secubat_client = SecubatClient.find(params[:id])
    @secubat_mailings = SecubatMailing.order("secubat_mailings.created_at DESC").all.includes(:secubat_model).where(:secubat_client_id => @secubat_client)
    @secubat_models = SecubatModel.all.where(:is_activated => true).order(:id)
    respond_to do |format|
      format.js {render :index}
    end
  end

  # PUT
  def send_mailings_model
    secubat_model = SecubatModel.find(params[:hidden][:field_model_mailing])

    @secubat_clients = []

    if !params[:m_ids].nil?
      params[:m_ids].each do |s|
        contact = SecubatClient.find_by_id(s)

        @secubat_clients << SecubatClient.find(s)

        @sm = SecubatMailing.find_by_secubat_client_id_and_secubat_model_id(contact.id, secubat_model.id)
        #if contact.is_admin?
          if ((secubat_model.is_unique? && !@sm) || !secubat_model.is_unique? || contact.is_admin?)
            @mailing = SecubatMailing.new(:secubat_model => secubat_model, :secubat_client => contact)
            @mailing.save
            Delayed::Job.enqueue MailingSecubat.new(secubat_model.template, contact, @mailing.id, secubat_model.subject, secubat_model.body, @mailing), :queue => "mailing-#{secubat_model.template}"
          end
        #end
      end
    end
    load_context
    respond_to do |format|
      format.js {render :index}
    end
  end

  def set_locale
    I18n.locale = :fr
  end

  def build_navigation
    @secubat_client = SecubatClient.find(params[:id])

    #conditions = ["project_id = ?", @todo.project_id]
    #unless params[:filter_status].nil? || params[:filter_status] == "0"
    #  conditions[0] += " AND status_id = ? "
    #  conditions.push(params[:filter_status])
    #end
    #unless params[:exclude_status].nil? || params[:exclude_status] == "0"
    #  conditions[0] += " AND status_id != ? "
    #  conditions.push(params[:exclude_status])
    #end

    conditions_previous = Array.new()
    conditions_next = Array.new()
    conditions_previous[0] = " id < ? "
    conditions_previous.push(@secubat_client.id)
    conditions_next[0] = " id > ? "
    conditions_next.push(@secubat_client.id)
    @secubat_client_previous = SecubatClient.where(conditions_previous).order("id DESC").first
    @secubat_client_next = SecubatClient.where(conditions_next).order("id ASC").first
  end

  private
  def secubat_client_params
    params.require(:secubat_client).permit(:first_name, :last_name, :email, :phone, :entreprise, :description, :gender, :is_admin)
  end
end
