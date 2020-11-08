class ApplicationController < ActionController::Base
    include SessionsHelper
    
    def counts(user)
        @count_events = user.events.count
        @count_followings = user.followings.count
        @count_followers = user.followers.count
    end
    
    private
    
        def require_logged_in
            unless logged_in?
                redirect_to login_path
            end
        end
        
        def already_logged_in
            redirect_to current_user if logged_in?
        end
end
