class Status < ActiveRecord::Base
  has_many :todos
end
