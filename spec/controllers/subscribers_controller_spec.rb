require 'rails_helper'

RSpec.describe SubscribersController, type: :controller do

  describe 'logged in user' do
    login_user

    describe 'index' do
      before do
        create(:subscriber)
        get :index
      end

      it { expect(assigns(:subscribers).size).to eq(1) }
      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template :index }
      it { expect(response.content_type).to eq 'text/html; charset=utf-8' }
    end

    describe 'show' do
      let(:subscriber) { create(:subscriber) }
      before do
        get :show, params: { id: subscriber.id }
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template :show }
    end

    describe 'new' do
      before do
        get :new
      end

      it { expect(assigns(:subscriber)).to be_a_new(Subscriber) }
      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template :new }
    end

    describe 'edit' do
      let(:subscriber) { create(:subscriber) }
      before do
        get :edit, params: { id: subscriber.id }
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template :edit }
    end

    describe 'create' do
      let(:subscriber) { create(:subscriber) }

      context 'Valid data' do
        before do
          allow(SubscriberServices::CreateSubscriber).to receive(:call).and_return(
            ServiceResponse.new(success: true,
                                resource: subscriber,
                                message: 'Subscriber was successfully created.')
          )
          post :create, params: {
            subscriber: subscriber.attributes.slice('email', 'name', 'source')
          }
        end

        it { expect(response).to have_http_status(:redirect) }
        it { expect(response).to redirect_to(subscribers_path) }
        it { expect(assigns(:subscriber)).to eq(subscriber) }
        it { expect(flash[:notice]).to eq('Subscriber was successfully created.') }
      end
    end

    describe 'update' do
      let(:subscriber) { create(:subscriber) }

      context 'Valid data' do
        before do
          put :update, params: {
            id: subscriber.id,
            subscriber: subscriber.attributes.slice('email', 'name', 'source')
          }
        end

        it { expect(response).to have_http_status(:redirect) }
        it { expect(response).to redirect_to(subscribers_path) }
        it { expect(assigns(:subscriber)).to eq(subscriber) }
        it { expect(flash[:notice]).to eq('Subscriber was successfully updated.') }
      end

      context 'invalid data' do
        before do
          subscriber.email = nil

          put :update, params: {
            id: subscriber.id,
            subscriber: subscriber.attributes.slice('email', 'name', 'source')
          }
        end

        it { expect(response).to have_http_status(:unprocessable_entity) }
        it { expect(response).to render_template :edit }
      end
    end

    describe 'destroy' do
      let(:subscriber) { create(:subscriber) }
      before do
        delete :destroy, params: { id: subscriber.id }
      end

      it { expect(response).to have_http_status(:redirect) }
      it { expect(response).to redirect_to(subscribers_url) }
      it { expect(flash[:notice]).to eq('Subscriber was successfully destroyed.') }
    end
  end

  describe 'logged out user' do
    describe 'confirm' do
      let(:subscriber) { create(:subscriber) }
      before do
        allow(SubscriberServices::ConfirmSubscription).to receive(:call).and_return(
          ServiceResponse.new(success: true,
                              resource: subscriber,
                              message: 'You subscribed successfully to our newsletter.')
        )

        get :confirm, params: { token: subscriber.confirmation_token }
      end

      it { expect(response).to have_http_status(:redirect) }
      it { expect(response).to redirect_to(root_path) }
    end
  end


end
