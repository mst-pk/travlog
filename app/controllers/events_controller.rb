class EventsController < ApplicationController
    require 'exifr/jpeg'
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
        5.times{ @event.event_pictures.build }
    end
    
    def create
        @event = current_user.events.build(event_params)
        get_location_from_jpeg if params[:address].nil?
        if @event.save
            flash[:success] = "投稿しました。"
            redirect_to events_url
        else
            flash.now[:danger] = "投稿に失敗しました。"
            render :new
        end
    end
    
    def edit
        @event = Event.find(params[:id])
        @event_picture = @event.event_pictures.where(event_id: @event.id)
        (5 - @event_picture.count).times{ @event.event_pictures.build }
    end
    
    def update
        @event = Event.find(params[:id])
        get_location_from_jpeg if params[:address].nil?
        @event.update(update_event_params)
        flash[:success] = "投稿を編集しました"
        redirect_to @event
    end
    
    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        flash[:success] = "投稿を削除しました。"
        redirect_to events_url
    end
    
    private
        def event_params
            params.require(:event).permit(:title, :comment, :event_date, :address, :latitude, :longitude, event_pictures_attributes: [:picture, :id])
        end
        
        def update_event_params
            params.require(:event).permit(:title, :comment, :event_date, :address, :latitude, :longitude, event_pictures_attributes: [:picture, :_destroy, :id])
        end
        
        def correct_user
            @event = current_user.events.find_by(params[:id])
            unless @event
                redirect_to users_url
            end
        end
        
        def get_location_from_jpeg
            @event.event_pictures.each do |pic|
                @jpg_gps = EXIFR::JPEG.new(pic.picture.file.file).gps
                if @jpg_gps.present?
                    @event.latitude = @jpg_gps.latitude
                    @event.longitude = @jpg_gps.longitude
                    break if @event.latitude.present? && @event.longitude.present?
                end
            end
        end
end
