class EventsController < ApplicationController
    require 'exifr/jpeg'
    before_action :require_logged_in
    before_action :correct_user, only: [:update, :destroy, :edit]
    before_action :get_travel, except: [:show]
    
    def show
        @travel = Travel.find_by(id: params[:travel_id])
        @event = @travel.events.find(params[:id])
        @event_picture = @event.event_pictures
    end
    
    def new
        @num = 0
        @event = @travel.events.build
        3.times{ @event.event_pictures.build }
    end
    
    def create
        @event = @travel.events.build(event_params)
        get_location_from_jpeg if params[:address].nil?
        if @event.save
            flash[:success] = "Eventを作成しました。"
            redirect_to [@travel,@event]
        else
            flash.now[:danger] = "作成に失敗しました。"
            render :new
        end
    end
    
    def edit
        @num = 0
        @event = @travel.events.find(params[:id])
        @event_picture = @event.event_pictures.where(event_id: @event.id)
        (3 - @event_picture.count).times{ @event.event_pictures.build }
    end
    
    def update
        @event = @travel.events.find(params[:id])
        @event.update(update_event_params)
        flash[:success] = "Eventを編集しました"
        redirect_to [@travel,@event]
    end
    
    def destroy
        @event = @travel.events.find(params[:id])
        @event.destroy
        flash[:success] = "Eventを削除しました。"
        redirect_to travel_url(@travel)
    end
    
    private
        def event_params
            params.require(:event).permit(:title, :comment, :event_date, :address, :latitude, :longitude, event_pictures_attributes: [:picture, :id])
        end
        
        def update_event_params
            params.require(:event).permit(:title, :comment, :event_date, :address, :latitude, :longitude, event_pictures_attributes: [:picture, :_destroy, :id])
        end
        
        def correct_user
            @travel = current_user.travels.find_by(id: params[:travel_id])
            unless @travel
                redirect_to users_url
                flash[:danger] = "無効な操作です。"
            end
        end
        
         def get_travel
            @travel = current_user.travels.find(params[:travel_id])
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
