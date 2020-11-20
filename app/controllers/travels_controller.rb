class TravelsController < ApplicationController
    before_action :require_logged_in
    before_action :correct_user, only: [:update, :destroy, :edit]
    before_action :get_travel, except: [:index, :show, :new, :create]
    
    def index
        @travels = Travel.where(user_id: current_user.followings.ids + [current_user.id]).order(id: :desc).page(params[:page])
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
    end
    
    def update
        if @travel.update(travel_params)
            flash[:success] = "編集しました。"
            redirect_to travel_url(@travel)
        else
            flash[:danger] = "編集に失敗しました。"
            render :new
        end
    end
    
    def destroy
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
        
        def get_travel
            current_user.travels.find(params[:id])
        end
end
