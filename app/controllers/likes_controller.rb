class LikesController < ApplicationController
  before_action :require_logged_in
  def create
    event = Event.find(params[:event_id])
    current_user.like(event)
    flash[:success] = "Good!しました。"
    redirect_back(fallback_location: users_url)
  end

  def destroy
    event = Event.find(params[:event_id])
    current_user.unlike(event)
    flash[:success] = "Good!を解除しました"
    redirect_back(fallback_location: users_url)
  end
end
