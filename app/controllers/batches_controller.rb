class BatchesController < ApplicationController

  def index
    edit_id = params[:edit_id]
    if edit_id == nil
      @batches = Batch.all
      @batch = Batch.new
    else
      @batches = Batch.all_except(edit_id)
      @batch = Batch.find(edit_id)
    end

  end

  def show
    @batch = Batch.find(params[:id])
    @interns = @batch.intern
  end

  def create
    @batch = Batch.new(batch_params)
    if @batch.save
      redirect_to batches_path
    else
      render 'index'
    end
  end

  def update
    @batch = Batch.find(params[:id])
    if @batch.update(batch_params)
      redirect_to batches_path
    else
      render 'index'
    end

  end

  def destroy
    batch = Batch.find(params[:id])
    batch.destroy if batch.intern.size <= 0
    redirect_to batches_path
  end

end

private

def batch_params
  params.require(:batch).permit(:id, :name, :start_date, :end_date,
                                email_attributes: [:id, :category, :address])
end

