class HomeController < ApplicationController
  def page
    @subscriber = Subscriber.new
  end

  def subscribe_user
    sub_user_resp = HomeServices::SubscribeUser.call(subscriber_params)

    respond_to do |format|
      if sub_user_resp.success?
        format.html { redirect_to root_path, notice: sub_user_resp.message }
      else
        @subscriber = sub_user_resp.resource
        flash[:alert] = sub_user_resp.message if sub_user_resp.message
        format.html { render :page, status: :unprocessable_entity  }
      end
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
