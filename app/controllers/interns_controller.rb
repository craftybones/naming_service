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
    @intern = set_profile_picture(params[:profile_picture], @intern)
    if @intern.update(intern_params)
      redirect_to intern_path
    else
      @batches = Batch.all
      render 'edit'
    end
  end

  def create
    @intern = Intern.new(intern_params)
    @intern = set_profile_picture(params[:profile_picture], @intern)
    if @intern.save
      redirect_to intern_path(@intern)
    else
      @batches = Batch.all
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

def set_profile_picture(profile_picture, intern)
  if profile_picture.present?
    preloaded = Cloudinary::PreloadedFile.new(profile_picture)
    raise "Invalid upload signature" if !preloaded.valid?
    intern[:profile_picture] = preloaded.identifier
  end
  intern
end