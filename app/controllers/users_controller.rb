class UsersController < ApplicationController
    before_action :require_logged_in, only: [:index, :show, :edit, :destroy]
    before_action :already_logged_in, only: [:new, :create]
    
    def index
        @users = User.order(id: :desc).page(params[:page]).per(30)
    end
    
    def show
        @user = User.find(params[:id])
    end
    
    def edit
    end
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "ようこそ！TraVLogへ！"
            redirect_to @user
        else
            flash.now[:danger] = "新規登録に失敗しました。"
            render :new
        end
    end
    
    def destroy
    end
    
    private
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation, :birthday, :gender, :image, :background_image, :about)
        end
end
