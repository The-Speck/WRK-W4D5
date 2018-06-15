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

  describe 'GET #new' do
    it 'renders the sign up page' do
      get :new

      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with invalid params' do
      it 'does not validate the presence of username and password' do
        post :create, params: { user: { username: 'usernamesreas' } }
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end

    context 'with valid params' do
      it 'validates the presence of username and password' do
        post :create, params: { user: { username: 'usernamesreas', password: 'password123' }}
        expect(response).to redirect_to(user_url(User.last.id))
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit user page' do
      get :edit, params: { id: user.id }

      expect(response).to render_template('edit')
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'renders the all users page' do
      get :show, params: { id: user.id }

      expect(response).to render_template('show')
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH #update' do
    context 'with invalid params' do
      it 'does not validate the presence of username and password' do

        put :update, params: { user: { username: 'usernamesreas', password: "" }, id: user.id  }
        expect(response).to render_template('edit')
        expect(flash[:errors]).to be_present
      end
    end

    context 'with valid params' do
      it 'validates the presence of username and password' do
        put :update, params: { user: { username: 'usernamesreas', password: 'password123' }, id: user.id }
        expect(response).to redirect_to(user_url(User.last.id))
      end
    end
  end


  describe 'DELETE #destroy' do
    it 'renders the all users page' do
      get :destroy, params: { id: user.id }

      expect(response).to render_template('index')
      expect(response).to have_http_status(200)
    end
  end
end
