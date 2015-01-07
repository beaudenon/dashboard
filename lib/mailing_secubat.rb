require 'yaml'

class MailingSecubat < Struct.new(:template, :user, :mailing_id, :subject, :body, :mailing)

  def perform
    SecubatMailer.send(template, user, mailing_id, subject, body, mailing).deliver
    #AdminMailer.send(template, user, host).deliver
  end

  def save_status job, status, exception
    handler = YAML::load(job.handler)
    #model = SecubatModel.find_by_template(handler.template)
    #mailing = SecubatMailing.find_by_secubat_client_id_and_secubat_model_id_and_created_at(handler.user.id, model.id, job.created_at)
    mailing = SecubatMailing.find_by_id(handler.mailing_id)
    mailing.sent_at = Time.now
    mailing.status = status unless mailing.status == "invalid"
    if status == "failed"
      mailing.last_error = "#{exception} --- #{job.last_error}"
    end
    mailing.save
  end

  def success(job)
    save_status job, "success", nil
  end

  def error(job, exception)
    save_status job, "failed", exception
  end


end