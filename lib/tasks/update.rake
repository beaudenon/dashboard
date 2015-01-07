namespace :update do

  desc "Update Todos Progress"
  task :todos_progress => :environment do
    todos = Todo.all
    todos.each do |t|
      t.progress = t.status.progress
      t.save
    end
  end

end