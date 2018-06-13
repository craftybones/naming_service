class InternsController < ApplicationController

  def index
    @interns = Intern.all
  end

  def new
    @intern = Intern.new
    @batches = Batch.all
  end

  def show
    @intern = Intern.find(params[:id])
  end

  def edit
    @intern = Intern.find(params[:id])
    @batches = Batch.all
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
    if @intern.save
      redirect_to intern_path(@intern)
    else
      render 'new'
    end
  end

  def destroy
    @intern = Intern.find(params[:id])
    @intern.destroy

    redirect_to interns_path
  end

  def bulk_import
  end

  def import
    @results = InternsCsvImportService.new(params[:file]).import
    render 'import_results'
  end

  def search
    @interns = Intern.search(params[:q])
  end
end


private

def intern_params
  params.require(:intern).permit(:id, :emp_id, :display_name, :first_name, :last_name, :batch_id, :gender,
                                 :dob, :phone_number, :present_in_tw,
                                 github_attributes: [:id, :username], slack_attributes: [:id, :username],
                                 dropbox_attributes: [:id, :username],
                                 emails_attributes: [:id, :category, :address])
end