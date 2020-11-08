class UsersController < ApplicationController
    before_action :require_logged_in, only: [:index, :show, :edit, :update, :destroy]
    before_action :already_logged_in, only: [:new, :create]
    
    def index
        @users = User.order(id: :desc).page(params[:page]).per(30)
    end
    
    def show
        @user = User.find(params[:id])
        counts(@user)
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        if current_user == @user
            if @user.update(user_params)
                flash[:success] = "編集しました"
                redirect_to @user
            else
                flash.now[:danger] = "編集に失敗しました。"
                render :edit
            end
        else
            users_path
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
            redirect_to @user
        else
            flash.now[:danger] = "新規登録に失敗しました。"
            render :new
        end
    end
    
    def destroy
        @user = User.find(params[:id])
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
        @user = User.find(params[:id])
        @followings = @user.followings
        counts(@user)
    end
    
    def followers
        @user = User.find(params[:id])
        @followers = @user.followers
        counts(@user)
    end
    
    private
    
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation, :birthday, :gender, :image, :background_image, :about)
        end
        
end
