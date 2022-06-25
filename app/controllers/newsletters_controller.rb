class NewslettersController < ApplicationController
  before_action :set_newsletter, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @newsletters = Newsletter.includes(:user).order(:publish_at)
  end

  def show; end

  def new
    @newsletter = Newsletter.new
  end

  def edit; end

  def create
    @newsletter = current_user.newsletters.new(newsletter_params)

    respond_to do |format|
      if @newsletter.save
        format.html { redirect_to newsletters_url, notice: 'Newsletter was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    update_resp = NewsletterServices::UpdateNewsletter.call(@newsletter, newsletter_params)

    respond_to do |format|
      if update_resp.success?
        format.html { redirect_to newsletters_url, notice: update_resp.message }
      else
        @newsletter = update_resp.resource
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @newsletter.destroy

    respond_to do |format|
      format.html { redirect_to newsletters_url, notice: 'Newsletter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_newsletter
    @newsletter = Newsletter.find(params[:id])
  end

  def newsletter_params
    params.require(:newsletter).permit(:title, :body, :publish_at)
  end
end
