class SecubatClient < ActiveRecord::Base
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_uniqueness_of :email

  has_many :secubat_mailings
  has_many :secubat_models, :through => :secubat_mailings

  scope :mailing_voeux_sent, where(:mailing_voeux => true)

end
