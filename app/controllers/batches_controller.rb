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

  def create
    @batch = Batch.new(batch_params)
    @batch.save
    redirect_to batches_path
  end

  def update
    batch = Batch.find(params[:id])
    batch.update(batch_params)
    redirect_to batches_path
  end

  def destroy
    Batch.find(params[:id]).destroy
    redirect_to batches_path
  end

end

private

def batch_params
  params.require(:batch).permit(:id, :name, :start_date, :end_date)
end

