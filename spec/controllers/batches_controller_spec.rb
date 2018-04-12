require 'rails_helper'

RSpec.describe BatchesController, type: :controller do
  describe 'GET index' do
    it 'should render index template' do
      get :index
      expect(response).to render_template('batches/index')
    end

    it 'should give the list of batches' do
      batches = [double('Batch')]
      expect(Batch).to receive(:all).and_return(batches)
      get :index

      expect(assigns(:batches)).to eq(batches)
    end

    it 'should build an empty batch for creation of new batch' do
      get :index

      expect(assigns(:batch)).to be_a_new(Batch)
    end

    it 'should give list of batches except the given editing batch id' do
      batches = [double('Batch')]
      expect(Batch).to receive(:all_except).with('1').and_return(batches)
      allow(Batch).to receive(:find)
      get :index, params: {edit_id: 1}

      expect(assigns(:batches)).to eq(batches)
    end

    it 'should build a batch with the given edit batch details' do
      batch = double('Batch')
      allow(Batch).to receive(:all_except)
      allow(Batch).to receive(:find).with('1').and_return(batch)
      get :index, params: {edit_id: 1}

      expect(assigns(:batch)).to eq(batch)
    end
  end

  describe 'POST create' do
    it 'should redirect to the batches list page after creation of an batch' do
      batch = double('Batch', id: 'id')
      batch_attributes = {name: 'STEP-1'}

      allow_any_instance_of(BatchesController).to receive(:batch_params).and_return(batch_attributes)
      expect(Batch).to receive(:new).with(batch_attributes).and_return(batch)
      expect(batch).to receive(:save).and_return(true)

      post :create, params: {name: 'STEP-1'}

      expect(response).to redirect_to(batches_path)
    end
  end

  describe 'DELETE destroy' do
    it 'should delete' do
      batch = double('Batch', id: 'id')

      expect(Batch).to receive(:find).with('id').and_return(batch)
      expect(batch).to receive(:destroy)

      delete :destroy, params: {id: 'id', name: 'STEP-1'}

      expect(response).to redirect_to(batches_path)
    end
  end

  describe 'PUT update' do
    before(:each) do
      @batch = double('Batch', id: 'id')
      @batch_attributes = {name: 'STEP-1'}

      expect(Batch).to receive(:find).and_return(@batch)
      allow_any_instance_of(BatchesController).to receive(:batch_params).and_return(@batch_attributes)
    end

    it 'should redirect to the batches list page' do
      expect(@batch).to receive(:update).with(@batch_attributes).and_return(true)

      post :update, params: {id: 'id', name: 'STEP-1'}
      expect(response).to redirect_to(batches_path)
    end
  end

end
