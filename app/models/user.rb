class User < ActiveRecord::Base
  #NAME========================
  before_save { self.email = email.downcase }
  validates :name, presence: true
  #EMAIL===========================
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
    format:{ with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false } 

#Password
  has_secure_password
  validates :password, presence: true, length:{ minimum: 6 }

end 

