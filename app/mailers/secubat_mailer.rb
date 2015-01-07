class SecubatMailer < ActionMailer::Base
  default from: "michel.beaudenon@secubat.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.secubat_mailing.voeux2012.subject
  #

  def pub(user, mailing_id, subject, body, mailing)
    @trackerModel = mailing.secubat_model_id
    @trackerMailing = mailing.id
    if (user.first_name.length > 2)
      @username = "#{user.gender.capitalize} #{user.first_name} #{user.last_name}"
    else
      @username = "#{user.gender.capitalize} #{user.last_name}"
    end
    @bodymail = body
    mail to: user.email, subject: "#{subject}"
  end

  def voeux2012(user, mailing_id, subject, body, mailing)
    mail to: user.email, subject: "#{subject}"
  end

  def voeux2013(user, mailing_id, subject, body, mailing)
    @trackerModel = mailing.secubat_model_id
    @trackerMailing = mailing.id
    if (user.first_name.length > 2)
      @username = "#{user.gender.capitalize} #{user.first_name} #{user.last_name}"
    else
      @username = "#{user.gender.capitalize} #{user.last_name}"
    end
    @bodymail = body
    mail to: user.email, subject: "#{subject}"
  end

  def voeux2014(user, mailing_id, subject, body, mailing)
    @trackerModel = mailing.secubat_model_id
    @trackerMailing = mailing.id
    if (user.first_name.length > 2)
      @username = "#{user.gender.capitalize} #{user.first_name} #{user.last_name}"
    else
      @username = "#{user.gender.capitalize} #{user.last_name}"
    end
    @bodymail = body
    mail to: user.email, subject: "#{subject}"
  end
end
