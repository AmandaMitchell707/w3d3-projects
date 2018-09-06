class ShortenedUrl < ApplicationRecord
  include SecureRandom
  
  validates :long_url, presence: true, uniqueness: true
  
  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
    #uniqueness: false
    
  def self.create_shortened_url(user, long_url)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.create!(user_id: user, long_url: long_url, short_url: short_url)
  end
    
  def self.random_code
    code = SecureRandom.urlsafe_base64
    while self.exists?(short_url: code) 
      code = SecureRandom.urlsafe_base64
    end
    code
  end 
end