require 'rails_helper'

RSpec.describe NursesController, type: :controller do
  let!(:role) { Role.create({name: 'test_role'}) }
  let!(:nurse1) { Nurse.create({email: 'test1@test.com', first_name: 'test1', last_name: 'test1', role: role, verified: true, sign_in_count: 0}) }
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

    it 'responds with an error message when an invalid id is given' do
      get :show, params: { id: 9999 }
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)['message']).to eq 'Could not find nurse with id: 9999'
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
                                      role: role,
                                      phone_number: '555 0123',
                                      verified: true,
                                      sign_in_count: 0
                                    }
      }.to change(Nurse, :count).by(1)
    end

    it 'responds with an error message if invalid details are given' do
      post :create, params: { role: role, email: 'invalid_email' }
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)['message']).to eq('Invalid details - record not created')
    end
  end

  describe 'PUT /update' do
    it 'responds with 200' do
      put :update, params: { id: nurse1.id }
      expect(response).to have_http_status(200)
    end

    it 'updates the details of a nurse' do
      put :update, params: { id: nurse1.id, first_name: 'new_fname', last_name: 'new_lname', email: 'newemail@test.com' }
      expect(JSON.parse(response.body)['message']).to eq("Updated details for nurse with id: #{nurse1.id}")
    end

    it 'sends an error message when invalid details are given' do
      put :update, params: { id: nurse1.id, email: 'invalid_email' }
      expect(JSON.parse(response.body)['message']).to eq('Edit unsuccessful')
    end

    it 'sends an error message when the record does not exist' do
      put :update, params: { id: 9999 }
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)['message']).to eq('Could not find nurse with id: 9999')
    end
  end

  describe 'DELETE /' do
    it 'responds with 200' do
      delete :destroy, params: { id: nurse1.id }
      expect(response).to have_http_status(200)
    end

    it 'deletes the nurse record' do
      expect { delete :destroy, params: { id: nurse1.id } }.to change(Nurse, :count).by(-1)
      expect(JSON.parse(response.body)['message']).to eq("Deleted records for nurse with id: #{nurse1.id}")
    end

    it 'responds with an error message when the record does not exist' do
      delete :destroy, params: { id: 9999 }
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)['message']).to eq('Could not find nurse with id: 9999')
    end
  end
end
