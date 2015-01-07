class TodosController < ApplicationController
  layout "empty"
  include ActionView::Helpers::TextHelper
  # GET /todos
  # GET /todos.json
  def index
    load_context
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    @todo = Todo.find(params[:id])
    navigation

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])
    navigation
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(params[:todo])

    respond_to do |format|
      if @todo.save
        case params["commit"]
          when "Save and Back to the project" then format.html { redirect_to todos_path(:filter_project => @todo.project.id, :filter_status => params[:hidden][:filter_status], :exclude_status => params[:hidden][:exclude_status]), notice: 'Todo was successfully created.' }
          when "Save and Insert" then format.html {redirect_to new_todo_path(:filter_project => @todo.project.id, :filter_status => params[:hidden][:filter_status], :exclude_status => params[:hidden][:exclude_status]), notice: 'Todo was successfully created.' }
        else
          format.html { redirect_to todo_path(:id => @todo.id, :filter_project => @todo.project.id, :filter_status => params[:hidden][:filter_status], :exclude_status => params[:hidden][:exclude_status]), notice: 'Todo was successfully created.' }
          format.json { render json: @todo, status: :created, location: @todo }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.json
  def update
    @todo = Todo.find(params[:id])
    @previous_todo = Todo.find(params[:id])
    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        if @previous_todo.status_id != @todo.status_id
          @todo.progress = @todo.status.progress
          @todo.past_time = @todo.estimated_time unless @todo.progress != 100 or @todo.past_time != 0
        end
        if @todo.progress == 100
          @todo.finished_at = DateTime.now
        else
          @todo.finished_at = nil
        end
        if @previous_todo.difficulty != @todo.difficulty
          @todo.estimated_time = calculate_estimated_time @todo.difficulty
        end
        @todo.save
        navigation
        case params["commit"]
          when "Save and Back to the project" then format.html { redirect_to todos_path(:filter_project => @todo.project.id, :filter_status => params[:hidden][:filter_status], :exclude_status => params[:hidden][:exclude_status]), notice: 'Todo was successfully updated.' }
          when "Save and Insert" then format.html {redirect_to new_todo_path(:filter_project => @todo.project.id, :filter_status => params[:hidden][:filter_status], :exclude_status => params[:hidden][:exclude_status]), notice: 'Todo was successfully updated.' }
          when "Save and Previous" then format.html { redirect_to edit_todo_path(:id => @todo_previous.id, :filter_project => @todo.project.id, :filter_status => params[:hidden][:filter_status], :exclude_status => params[:hidden][:exclude_status]), notice: 'Todo was successfully updated.' }
          when "Save and Next" then format.html { redirect_to edit_todo_path(:id => @todo_next.id, :filter_project => @todo.project.id, :filter_status => params[:hidden][:filter_status], :exclude_status => params[:hidden][:exclude_status]), notice: 'Todo was successfully updated.' }
          else format.html { redirect_to todo_path(:id => @todo.id, :filter_project => @todo.project.id, :filter_status => params[:hidden][:filter_status], :exclude_status => params[:hidden][:exclude_status]), notice: 'Todo was successfully updated.' }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_path(:filter_project => params[:filter_project], :filter_status => params[:filter_status], :exclude_status => params[:exclude_status]) }
      format.json { head :ok }
    end
  end

  # POST
  def update_status
    @todo = Todo.find(params[:id])
    @previous_todo = Todo.find(params[:id])
    @todo.status = Status.find(params[:status_id])
    if @previous_todo.progress == @todo.progress
      @todo.progress = @todo.status.progress
    end
    if @todo.progress == 100
      @todo.finished_at = DateTime.now
    else
      @todo.finished_at = nil
    end
    @todo.save
    load_context

    respond_to do |format|
      format.js {render :index}
    end
  end

  def update_type
    @todo = Todo.find(params[:id])
    @todo.type = Type.find(params[:type_id])
    @todo.save
    load_context
    respond_to do |format|
      format.js {render :index}
    end
  end

  def update_difficulty
    @todo = Todo.find(params[:id])
    @todo.difficulty = params[:difficulty_id]
    @todo.estimated_time = calculate_estimated_time @todo.difficulty
    @todo.save
    load_context
    respond_to do |format|
      format.js {render :index}
    end
  end

  def calculate_estimated_time difficulty
    estimated_time = case difficulty
      when 1 then 10
      when 2 then 30
      when 3 then 60
      when 4 then 120
      when 5 then 240
      else 500
    end
  end

  def update_emergency
    @todo = Todo.find(params[:id])
    @todo.emergency = params[:emergency_id]
    @todo.save
    load_context
    respond_to do |format|
      format.js {render :index}
    end
  end

  def update_importance
    @todo = Todo.find(params[:id])
    @todo.importance = params[:importance_id]
    @todo.save
    load_context
    respond_to do |format|
      format.js {render :index}
    end
  end

  def load_context
    @todos = Todo.paginate(:page => params[:page], :per_page => 20).with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).all(:order => "created_at DESC")
    @count_todos_total = Todo.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).count
    @count_todos_tbd = Todo.with_tbd_status.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).count
    @count_todos_urgent = Todo.with_urgent_status.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).count
    @count_todos_started = Todo.with_started_status.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).count
    @count_todos_current = Todo.with_current_status.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).count
    @count_todos_done = Todo.with_completed_status.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).count
    @count_percent_total = Todo.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).all.inject(0){|sum, todo| sum += todo.emergency * todo.importance}
    @count_percent_done = Todo.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).inject(0){|sum, todo| sum += todo.emergency * todo.importance * todo.progress / 100}
    @progression_percent = @count_percent_total == 0 ? 0 : @count_percent_done.to_f / @count_percent_total.to_f
    @projects = Project.all(:include => :todos).sort_by { |u| -u.todos.size }
    @statuses = Status.all(:order => "position ASC")
    @types = Type.all(:order => "position ASC")
    @current_project = Project.find(params[:filter_project]) unless params[:filter_project].nil? || params[:filter_project] == "0"
  end

  def navigation
    @todo = Todo.find(params[:id])
    conditions = ["project_id = ?", @todo.project_id]
    unless params[:filter_status].nil? || params[:filter_status] == "0"
      conditions[0] += " AND status_id = ? "
      conditions.push(params[:filter_status])
    end
    unless params[:exclude_status].nil? || params[:exclude_status] == "0"
      conditions[0] += " AND status_id != ? "
      conditions.push(params[:exclude_status])
    end
    conditions_previous = Array.new(conditions)
    conditions_next = Array.new(conditions)
    conditions_previous[0] += " AND id < ? "
    conditions_previous.push(@todo.id)
    conditions_next[0] += " AND id > ? "
    conditions_next.push(@todo.id)
    @todo_previous = Todo.first(:conditions => conditions_previous, :order => "id DESC")
    @todo_next = Todo.first(:conditions => conditions_next, :order => "id ASC")
  end

  def search
    respond_to do |format|
      if params["commit"].nil? || params["commit"] != "Filter without search"
          pattern = params[:pattern]
          @todos = Todo.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).all(:conditions => ['title LIKE ? OR description LIKE ?', "%#{pattern}%", "%#{pattern}%"])
          @count_todos_total = Todo.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).all(:conditions => ['title LIKE ? OR description LIKE ?', "%#{pattern}%", "%#{pattern}%"]).count
          @count_todos_tbd = Todo.with_tbd_status.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).all(:conditions => ['title LIKE ? OR description LIKE ?', "%#{pattern}%", "%#{pattern}%"]).count
          @count_todos_urgent = Todo.with_urgent_status.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).all(:conditions => ['title LIKE ? OR description LIKE ?', "%#{pattern}%", "%#{pattern}%"]).count
          @count_todos_urgent = Todo.with_started_status.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).all(:conditions => ['title LIKE ? OR description LIKE ?', "%#{pattern}%", "%#{pattern}%"]).count
          @count_todos_current = Todo.with_current_status.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).all(:conditions => ['title LIKE ? OR description LIKE ?', "%#{pattern}%", "%#{pattern}%"]).count
          @count_todos_done = Todo.with_completed_status.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).all(:conditions => ['title LIKE ? OR description LIKE ?', "%#{pattern}%", "%#{pattern}%"]).count
          @count_percent_total = Todo.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).all(:conditions => ['title LIKE ? OR description LIKE ?', "%#{pattern}%", "%#{pattern}%"]).inject(0){|sum, todo| sum += todo.emergency * todo.importance}
          @count_percent_done = Todo.with_filter_project(params[:filter_project]).with_filter_status(params[:filter_status]).without_filter_status(params[:exclude_status]).all(:conditions => ['title LIKE ? OR description LIKE ?', "%#{pattern}%", "%#{pattern}%"]).inject(0){|sum, todo| sum += todo.emergency * todo.importance * todo.progress / 100}
          @progression_percent = @count_percent_total == 0 ? 0 : @count_percent_done.to_f / @count_percent_total.to_f
          @projects = Project.all(:include => :todos).sort_by { |u| -u.todos.size }
          @statuses = Status.all(:order => "position ASC")
          @types = Type.all(:order => "position ASC")
          @current_project = Project.find(params[:filter_project]) unless params[:filter_project].nil? || params[:filter_project] == "0"
          if (@count_todos_total == 0)
            flash[:alert] = "Nothing found"
            flash[:notice] = nil
          else
            flash[:notice] = "Found for <i>#{pattern}</i>: #{pluralize(@todos.count, "result")} in todos".html_safe
            flash[:alert] = nil
          end
          format.html {render :search}
        else
          load_context
          format.html { redirect_to todos_path(:filter_project => params[:filter_project], :filter_status => params[:filter_status], :exclude_status => params[:exclude_status]) }
      end
    end
  end
end
