require 'rails_helper'

RSpec.describe NewslettersController, type: :controller do

  login_user

  describe 'index' do
    before do
      create(:newsletter)
      get :index
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(assigns(:newsletters).size).to eq(1) }
    it { expect(response).to render_template :index }
    it { expect(response.content_type).to eq 'text/html; charset=utf-8' }
  end

  describe 'show' do
    let(:newsletter) { create(:newsletter) }
    before do
      get :show, params: { id: newsletter.id }
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template :show }
  end

  describe 'new' do
    before do
      get :new
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template :new }
  end

  describe 'edit' do
    let(:newsletter) { create(:newsletter) }
    before do
      get :edit, params: { id: newsletter.id }
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template :edit }
  end

  describe 'create' do
    let(:newsletter) { build(:newsletter) }
    before do
      post :create, params: {
        newsletter: newsletter.attributes.slice('title', 'body', 'publish_at')
      }
    end

    context 'Valid data' do
      it { expect(response).to have_http_status(:redirect) }
      it { expect(response).to redirect_to(newsletters_path) }
      it { expect(assigns(:newsletter).title).to eq(newsletter.title) }
      it { expect(assigns(:newsletter).body).to eq(newsletter.body) }
      it { expect(assigns(:newsletter).publish_at.to_s).to eq(newsletter.publish_at.to_s) }
    end

    context 'invalid data' do
      let(:newsletter) { build(:newsletter, title: nil) }
      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(response).to render_template :new }
    end
  end

  describe 'update' do
    let(:newsletter) { create(:newsletter) }

    context 'Valid data' do
      before do
        put :update, params: {
          id: newsletter.id,
          newsletter: newsletter.attributes.slice('title', 'body', 'publish_at')
        }
      end

      it { expect(response).to have_http_status(:redirect) }
      it { expect(response).to redirect_to(newsletters_path) }
      it { expect(assigns(:newsletter).title).to eq(newsletter.title) }
      it { expect(assigns(:newsletter).body).to eq(newsletter.body) }
      it { expect(assigns(:newsletter).publish_at.to_s).to eq(newsletter.publish_at.to_s) }
    end

    context 'invalid data' do
      before do
        newsletter.title = nil
        newsletter.publish_at = Time.now - 10.minutes.ago

        put :update, params: {
          id: newsletter.id,
          newsletter: newsletter.attributes.slice('title', 'body', 'publish_at')
        }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(response).to render_template :edit }
    end
  end

  describe 'destroy' do
    let(:newsletter) { create(:newsletter) }
    before do
      delete :destroy, params: { id: newsletter.id }
    end

    it { expect(response).to have_http_status(:redirect) }
    it { expect(response).to redirect_to(newsletters_path) }
  end
end
