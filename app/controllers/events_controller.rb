class EventsController < ApplicationController
    before_action :require_logged_in
    before_action :correct_user, only: [:update, :destroy]
    
    def index
        @events = Event.order(id: :desc).page(params[:page])
    end
    
    def show
        @event = Event.find(params[:id])
        @event_picture = @event.event_pictures.all
        @user = @event.user
    end
    
    def new
        @event = current_user.events.build
        @event_picture = @event.event_pictures.build
    end
    
    def create
        @event = current_user.events.build(event_params)
        if @event.save
            if params[:event_pictures].present?
                params[:event_pictures][:picture].each do |pic|
                    @event.event_pictures.create!(picture: pic, event_id: @event.id)
                end
            end
            flash[:success] = "投稿しました。"
            redirect_to events_url
        else
            flash.now[:danger] = "投稿に失敗しました。"
            render :new
        end
    end
    
    def edit
        @event = Event.find(params[:id])
    end
    
    def update
        @event.update(event_params)
        flash[:success] = "投稿を編集しました"
        redirect_to @event
    end
    
    def destroy
        @event.destroy
        flash[:success] = "投稿を削除しました。"
        redirect_to events_url
    end
    
    private
        def event_params
            params.require(:event).permit(:title, :comment, :event_date, :address, :latitude, :longitude, event_pictures_attributes: :picture)
        end
        
        def correct_user
            @event = current_user.events.find_by(params[:id])
            unless @event
                redirect_to users_url
            end
        end
end
