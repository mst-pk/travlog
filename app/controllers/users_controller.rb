class UsersController < ApplicationController
    before_action :require_logged_in, only: [:index, :show, :edit, :update, :destroy]
    before_action :already_logged_in, only: [:new, :create]
    before_action :get_user_from_params, except: [:index, :new, :create]
    
    def index
        @users = User.order(id: :desc).page(params[:page]).per(30)
    end
    
    def show
        counts(@user)
    end
    
    def edit
    end
    
    def update
        if current_user == @user
            if @user.update(user_params)
                flash[:success] = "編集しました"
                redirect_to @user
            else
                flash.now[:danger] = "編集に失敗しました。"
                render :edit
            end
        else
            flash[:danger] = "無効な操作です。"
            redirect_to users_url
        end
    end
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "ようこそ！TraVLogへ！"
            redirect_to travels_url
        else
            flash.now[:danger] = "新規登録に失敗しました。"
            render :new
        end
    end
    
    def destroy
        if current_user == @user
            @user.destroy
            flash[:success] = "ユーザーを削除しました。"
            redirect_to root_url
        else
            flash[:danger] = "無効な操作です。"
            redirect_to users_url
        end
    end
    
    def followings
        @followings = @user.followings.order(id: :desc).page(params[:page]).per(30)
        counts(@user)
    end
    
    def followers
        @followers = @user.followers.order(id: :desc).page(params[:page]).per(30)
        counts(@user)
    end
    
    def likes
        @likes = @user.like_events.order(id: :desc).page(params[:page]).per(30)
    end
    
    def favorites
        @favorites = @user.favorite_travels.order(id: :desc).page(params[:page]).per(30)
    end
    
    def nonreleased
        @travels = @user.travels.nonreleased
        redirect_to user_path(@user) unless current_user == @user
    end
    
    private
    
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation, :birthday, :gender, :image, :background_image, :about)
        end
        
        def get_user_from_params
            @user = User.find(params[:id])
        end
        
end
