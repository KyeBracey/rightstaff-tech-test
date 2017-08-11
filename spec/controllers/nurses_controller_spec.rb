require 'rails_helper'

RSpec.describe NursesController, type: :controller do
  let!(:role) { Role.create({name: 'test_role'}) }
  let!(:nurse1) { Nurse.create({email: 'test1@test.com', first_name: 'test1', last_name: 'test1', role: role}) }
  let!(:nurse2) { Nurse.create({email: 'test2@test.com', first_name: 'test2', last_name: 'test2', role: role}) }

  describe 'GET /' do
    it 'responds with 200' do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'returns a list of nurses' do
      get :index
      expect(assigns(:nurses)).to eq([nurse1, nurse2])
    end
  end

  describe 'GET /:id' do
    it 'responds with 200' do
      get :show, params: { id: nurse1.id }
      expect(response).to have_http_status(200)
    end

    it 'returns the details of one nurse' do
      get :show, params: { id: nurse1.id }
      expect(assigns(:nurse)).to eq(nurse1)
    end
  end

  describe 'POST /create' do
    it 'responds with 200' do
      post :create, params: { first_name: 'test', last_name: 'test', email: 'test@test.com', role: role }
      expect(response).to have_http_status(200)
    end

    it 'creates a new nurse entry' do
      expect{ post :create, params: {
                                      first_name: 'test',
                                      last_name: 'test',
                                      email: 'test@test.com',
                                      role: role
                                    }
      }.to change(Nurse, :count).by(1)
    end
  end
end
