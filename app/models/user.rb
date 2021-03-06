class User < ApplicationRecord
    before_save { self.email.downcase! }
    
    has_many :travels, dependent: :destroy
    has_many :relationships, dependent: :destroy
    has_many :followings, through: :relationships, source: :follow
    has_many :reverse_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
    has_many :followers, through: :reverse_relationships, source: :user
    has_many :likes, dependent: :destroy
    has_many :like_events, through: :likes, source: :event
    has_many :favorites, dependent: :destroy
    has_many :favorite_travels, through: :favorites, source: :travel
    
    enum gender: { 男性: 0, 女性: 1, その他: 2 }
    
    mount_uploader :image, ImageUploader
    mount_uploader :background_image, ImageUploader
    
    has_secure_password
    
    validates :name, presence: true, length: { maximum: 20 }
    validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    
    def follow(other_user)
        unless self == other_user
            self.relationships.find_or_create_by(follow_id: other_user.id)
        end
    end
    
    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end
    
    def following?(other_user)
        self.followings.include?(other_user)
    end
    
    def like(event)
        self.likes.find_or_create_by(event_id: event.id)
    end
    
    def unlike(event)
        like = self.likes.find_by(event_id: event.id)
        like.destroy if like
    end
    
    def liked?(event)
        self.like_events.include?(event)
    end
    
    def favorite(travel)
        self.favorites.find_or_create_by(travel_id: travel.id)
    end
    
    def unfavorite(travel)
        travel = self.favorites.find_or_create_by(travel_id: travel.id)
        travel.destroy if travel
    end
    
    def favorite?(travel)
        self.favorite_travels.include?(travel)
    end
    
    def age
        birth_date = self.birthday
        (Date.today.strftime('%Y%m%d').to_i - birth_date.strftime('%Y%m%d').to_i) / 10000
    end
end
