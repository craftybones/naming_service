class InternsController < ApplicationController

  def index
    @interns = Intern.all
  end

  def new
    @intern = Intern.new
    @intern.build_dependents
  end

  def show
    @intern = Intern.find(params[:id])
  end

  def edit
    @intern = Intern.find(params[:id])
  end

  def update
    @intern = Intern.find(params[:id])

    if @intern.update(intern_params)
      redirect_to intern_path
    else
      render 'edit'
    end
  end

  def create
    @intern = Intern.new(intern_params)
    @intern.save

    redirect_to intern_path(@intern)
  end

  def destroy
    @intern = Intern.find(params[:id])
    @intern.destroy

    redirect_to interns_path
  end

  def search
    render json: Intern.search(params[:q]), include: [:github, :emails, :dropbox, :slack] if params[:q].present?
  end
end


private

  def intern_params
    params.require(:intern).permit(:id, :emp_id, :display_name, :first_name, :last_name, :batch, :gender, :dob,
                                   github_attributes: [:id, :username], slack_attributes: [:id, :username],
                                   dropbox_attributes: [:id, :username],
                                   emails_attributes: [:category, :address])
  end