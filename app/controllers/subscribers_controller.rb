class SubscribersController < ApplicationController
  before_action :set_subscriber, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: :confirm

  # GET /subscribers or /subscribers.json
  def index
    @subscribers = Subscriber.all
  end

  # GET /subscribers/1 or /subscribers/1.json
  def show; end

  # GET /subscribers/new
  def new
    @subscriber = Subscriber.new
  end

  # GET /subscribers/1/edit
  def edit; end

  # POST /subscribers or /subscribers.json
  def create
    create_resp = SubscriberServices::CreateSubscriber.call(subscriber_params)
    @subscriber = create_resp.resource

    respond_to do |format|
      if create_resp.success?
        format.html { redirect_to subscriber_url(@subscriber), notice: create_resp.message }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscribers/1 or /subscribers/1.json
  def update
    respond_to do |format|
      if @subscriber.update(subscriber_params)
        format.html { redirect_to subscriber_url(@subscriber), notice: 'Subscriber was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    confirm_response = SubscriberServices::ConfirmSubscription.call(params[:token])

    respond_to do |format|
      if confirm_response.success?
        format.html { redirect_to root_path, notice: confirm_response.message }
      else
        format.html { redirect_to root_path, alert: confirm_response.message }
      end
    end
  end

  def destroy
    @subscriber.destroy

    respond_to do |format|
      format.html { redirect_to subscribers_url, notice: 'Subscriber was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subscriber
    @subscriber = Subscriber.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def subscriber_params
    params.require(:subscriber).permit(:name, :email, :source)
  end
end