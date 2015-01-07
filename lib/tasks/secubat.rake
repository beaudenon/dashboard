namespace :secubat do

  desc "Create secubat mailings with voeux 2012"
  task :create_voeux2012 => :environment do
    contacts = SecubatClient.all(:conditions => {:mailing_voeux => "1"})
    voeux2012model = SecubatModel.find_by_template(:voeux2012)
    if voeux2012model.is_activated
      contacts.each do |contact|
        @mailing = SecubatMailing.new(:secubat_model => voeux2012model, :secubat_client => contact, :created_at => "2012-01-02", :updated_at => "2012-01-02", :sent_at => "2012-01-02", :status => :success)
        @mailing.save
      end
    end
    voeux2012model.is_activated = false
    voeux2012model.save
  end

end