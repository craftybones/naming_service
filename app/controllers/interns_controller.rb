class InternsController < ApplicationController

  def index
    @interns = Intern.all
  end

  def new
  end

  def show
    @intern = Intern.find(params[:id])
  end

  def create
    @intern = Intern.new(intern_params)

    @intern.save
    redirect_to @intern
  end

  def search
    @interns = Intern.search(params[:q]) unless params[:q] == nil
  end
end


private

  def intern_params
    params.require(:intern).permit(:display_name, :first_name, :last_name, :batch)
  end