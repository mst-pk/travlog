class User < ApplicationRecord
    before_save { self.email.downcase! }
    
    has_many :events
    
    enum gender: { 男: 0, 女: 1, その他: 2 }
    
    mount_uploader :image, ImageUploader
    mount_uploader :background_image, ImageUploader
    
    has_secure_password
    
    validates :name, presence: true, length: { maximum: 20 }
    validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
