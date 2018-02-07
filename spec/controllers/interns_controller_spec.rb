require 'rails_helper'

RSpec.describe InternsController, type: :controller do

  describe 'GET index' do
    it 'should render index template' do
      get :index

      expect(response).to render_template('interns/index')
    end

    it 'should give the list of interns' do
      intern = Intern.create
      get :index

      expect(assigns(:interns)).to eq([intern])
    end
  end

  describe 'GET new' do
    it 'should render new template' do
      get :new

      expect(response).to render_template('interns/new')
    end

    it 'should build the new empty intern' do
      get :new

      expect(assigns(:intern)).to be_a_new(Intern)
    end
  end

  describe 'GET an intern' do

    before(:each) do
      @actual_intern = double('Intern', display_name: 'Intern 1')
      allow(Intern).to receive(:find).with('1').and_return(@actual_intern)
    end

    it 'should render show template' do
      get :show, params: {id: 1}
      expect(response).to render_template('interns/show')
    end

    it 'should find the intern by given id' do
      get :show, params: {id: 1}

      expect(assigns(:intern)).to eq(@actual_intern)
    end
  end

  describe 'GET edit' do

    before(:each) do
      @actual_intern = double('Intern', display_name: 'Intern 1')
      allow(Intern).to receive(:find).with('1').and_return(@actual_intern)
    end

    it 'should render edit template' do
      get :edit, params: {id: 1}
      expect(response).to render_template('interns/edit')
    end

    it 'should find the intern by given id' do
      get :edit, params: {id: 1}

      expect(assigns(:intern)).to eq(@actual_intern)
    end
  end

  describe 'PUT update' do
    pending 'should redirect to the created intern' do
      intern = double('Intern', display_name: 'Intern 2')
      intern_attributes = {display_name: 'Intern 1'}

      allow(Intern).to receive(:find).and_return(intern)
      allow_any_instance_of(InternsController).to receive(:intern_params).and_return(intern_attributes)
      allow(intern).to receive(:update).with(intern_attributes).and_return(true)

      post :update, params: {id: '1', display_name: 'Intern 1'}

      expect(response).to redirect_to(interns_path)
    end

  end
end
