require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject (:user) { FactoryBot.create :user }

  describe 'GET #index' do
    it 'renders the all users page' do
      get :index

      expect(response).to render_template('index')
      expect(response).to have_http_status(200)
    end
  end

end
