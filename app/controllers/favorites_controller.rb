class FavoritesController < ApplicationController
    before_action :require_logged_in
    def create
        travel = Travel.find(params[:travel_id])
        current_user.favorite(travel)
        flash[:success] = "いいねしました。"
        redirect_back(fallback_location: users_url)
    end
    
    def destroy
        travel = Travel.find(params[:travel_id])
        current_user.unfavorite(travel)
        flash[:success] = "いいねを解除しました"
        redirect_back(fallback_location: users_url)
    end
end
