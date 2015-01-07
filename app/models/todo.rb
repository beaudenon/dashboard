class Todo < ActiveRecord::Base
  belongs_to :project
  belongs_to :status
  belongs_to :type

  scope :with_status, lambda {|status| includes(:status).where(:statuses => {:name => status}).order("todos.created_at DESC")}
  scope :with_tbd_status, includes(:status).where(:statuses => {:progress => "0"}).order("todos.created_at DESC")
  scope :with_urgent_status, includes(:status).where(:statuses => {:progress => "1"}).order("todos.created_at DESC")
  scope :with_started_status, includes(:status).where(:statuses => {:progress => "10"}).order("todos.created_at DESC")
  scope :with_current_status, includes(:status).where(:statuses => {:progress => "50"}).order("todos.created_at DESC")
  scope :with_completed_status, includes(:status).where(:statuses => {:progress => "100"}).order("todos.created_at DESC")
  scope :with_not_started_status, includes(:status).where(:statuses => {:progress => "0"}).order("todos.created_at DESC")
  scope :with_filter_project, lambda {|project| !project.nil? and project != "0" ? where(:project_id => project) : order("todos.created_at DESC")}
  scope :with_filter_status, lambda {|status| !status.nil? and status != "0" ? where(:status_id => status) : order("todos.created_at DESC")}
  scope :without_filter_status, lambda {|status| !status.nil? and status != "0" ? where("status_id != " + status) : order("todos.created_at DESC")}
end
