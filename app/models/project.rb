class Project < ActiveRecord::Base
  has_many :todos

  #default_scope select("projects.*, COUNT(todos.id) number_of_todos").joins(:todos).group(:id).order("number_of_todos DESC")
end
