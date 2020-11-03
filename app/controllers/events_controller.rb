class EventsController < ApplicationController
    before_action :require_logged_in
    
    def index
        @events = current_user.events.order(id: :desc).page(params[:page])
    end
    
    def show
        @event = current_user.events
    end
    
    def new
        @event = current_user.events.build
    end
    
    def create
        @event = current_user.events.build(event_params)
        if @event.save
            flash[:success] = "投稿しました。"
            redirect_to events_url
        else
            flash.now[:danger] = "投稿に失敗しました。"
            render :new
        end
    end
    
    def edit
    end
    
    def update
    end
    
    def destroy
    end
    
    private
        def event_params
            params.require(:event).permit(:title, :comment, :event_date, :address, :latitude, :longitude)
        end
end
