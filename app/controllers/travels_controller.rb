class TravelsController < ApplicationController
    before_action :require_logged_in
    before_action :correct_user, only: [:update, :destroy, :edit]
    
    def index
        @travels = Travel.order(id: :desc).page(params[:page])
    end
    
    def show
        @travel = Travel.find(params[:id])
        @events = @travel.events
        @user = User.find_by(id: @travel.user_id)
    end
    
    def new
        @travel = current_user.travels.build
    end
    
    def create
        @travel = current_user.travels.build(travel_params)
        if @travel.save
            flash[:success] = "Travelを作成しました。"
            redirect_to travels_url
        else
            flash[:danger] = "作成に失敗しました。"
            render :new
        end
    end
    
    def edit
        @travel = Travel.find(params[:id])
    end
    
    def update
        @travel = Travel.find(params[:id])
        if @travel.update(travel_params)
            flash[:success] = "編集しました。"
            redirect_to travels_url
        else
            flash[:danger] = "編集に失敗しました。"
            render :new
        end
    end
    
    def destroy
        @travel = Travel.find(params[:id])
        @travel.destroy
        flash[:success] = "Travelを削除しました"
        redirect_to travels_url
    end
    
    private
        def travel_params
            params.require(:travel).permit(:title, :travel_image, :genre, :start_date, :end_date)
        end
        
        def correct_user
            @travel = current_user.travels.find_by(id: params[:id])
            redirect_to travels_url unless @travel
        end
end
