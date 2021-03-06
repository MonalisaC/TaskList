class TasksController < ApplicationController

  def index
    @tasks = Task.order(:completion_date)
  end

  def show
    id = params[:id]
    @task = Task.find(id)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    # (name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date])
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    edit
    if !@task.nil?
      if @task.update(task_params)
        # (name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date])
        redirect_to tasks_path(@task.id)
      else
        render :edit
      end
    else
      redirect_to tasks_path
    end

  end

  def destroy
    id = params[:id]
    if @task = Task.find(id)
      @task.destroy
    end
    flash[:notice] = "You have successfully deleted the trip."
    redirect_to tasks_path
  end

  def mark_complete
    @task = Task.find(params[:id].to_i)
    @task.complete = Date.today
    @task.save
    redirect_to tasks_path
  end

  def unmark_complete
    @task = Task.find(params[:id].to_i)
    @task.complete = nil
    @task.save
    redirect_to tasks_path
  end

end

private

def task_params
  return params.require(:task).permit(:name, :description, :completion_date, :complete)
end
