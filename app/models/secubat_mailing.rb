class SecubatMailing < ActiveRecord::Base
  belongs_to :secubat_client
  belongs_to :secubat_model

  scope :with_status, lambda { |status| where(:status => status) }
  scope :sent_this_week_pending, -> { with_status("pending").where(["updated_at > ?", 1.week.ago]) }
  scope :sent_this_week_success, -> { with_status("success").where(["updated_at > ?", 1.week.ago]) }

end
