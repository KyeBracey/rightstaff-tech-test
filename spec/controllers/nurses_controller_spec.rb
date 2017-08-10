require 'rails_helper'

RSpec.describe NursesController, type: :controller do
  describe 'GET /' do
    it 'reponds with 200' do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end
