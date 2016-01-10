class ProjectsController < ApplicationController
  layout "empty"
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.includes(:todos).sort_by { |u| -u.todos.size }
    @projects_tasks_total = {}
    @projects_tasks_not_started = {}
    @projects_tasks_done = {}
    @projects_progression = {}
    @projects_time_total = {}
    @projects_estimated_time_total = {}
    @projects.each do |p|
      count_total_time = Todo.with_filter_project(p.id).all.inject(0){|sum, todo| sum += todo.past_time != 0 ? todo.past_time * (todo.progress / 100) : todo.estimated_time * (todo.progress / 100) }
      count_total_estimated_time = Todo.with_filter_project(p.id).all.inject(0){|sum, todo| sum += todo.estimated_time - (todo.estimated_time * (todo.progress / 100))}
      count_todos_total = Todo.with_filter_project(p.id).count
      count_todos_not_started = Todo.with_not_started_status.with_filter_project(p.id).count
      count_todos_done = Todo.with_completed_status.with_filter_project(p.id).count
      count_percent_total = Todo.with_filter_project(p.id).all.inject(0){|sum, todo| sum += todo.emergency * todo.importance}
      count_percent_done = Todo.with_filter_project(p.id).all.inject(0){|sum, todo| sum += todo.emergency * todo.importance * todo.progress / 100}
      @projects_time_total[p.id] = count_total_time
      @projects_estimated_time_total[p.id] = count_total_estimated_time
      @projects_tasks_total[p.id] = count_todos_total
      @projects_tasks_not_started[p.id] = count_todos_not_started
      @projects_tasks_done[p.id] = count_todos_done
      @projects_progression[p.id] = count_percent_total == 0 ? 0 : count_percent_done.to_f / count_percent_total.to_f
    end


    if request.url.include?("secubat")
      redirect_to secubat_clients_path
    else
      respond_to do |format|

        format.html # index.html.erb
        format.json { render json: @projects }

      end
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :ok }
    end
  end
end
