require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe 'page' do
    before do
      get :page
    end

    it { expect(assigns(:subscriber)).to be_a_new(Subscriber) }
    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template :page }
  end

  describe 'subscribe_user' do
    let(:subscriber) { build(:subscriber) }

    context 'Valid data' do
      before do
        allow(HomeServices::SubscribeUser).to receive(:call).and_return(
          ServiceResponse.new(success: true, message: 'You will receive an email to confirm subscription.')
        )
        post :subscribe_user, params: { subscriber: subscriber.attributes.slice('email') }
      end
      it { expect(response).to have_http_status(:redirect) }
      it { expect(response).to redirect_to(root_path) }
      it { expect(flash[:notice]).to eq('You will receive an email to confirm subscription.') }
    end

    context 'Invalid data' do
      before do
        allow(HomeServices::SubscribeUser).to receive(:call).and_return(
          ServiceResponse.new(success: false, message: 'Email is invalid.')
        )
        subscriber.email = nil
        post :subscribe_user, params: { subscriber: subscriber.attributes.slice('email') }
      end
      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(response).to render_template :page }
      it { expect(flash[:alert]).to eq('Email is invalid.') }
    end
  end
end
