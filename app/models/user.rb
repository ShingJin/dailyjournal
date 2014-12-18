class User < ActiveRecord::Base


  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  attr_accessor :password
  before_save :encrypt_password
  
  before_create { generate_token(:auth_token) }
  has_many :entries, :dependent => :destroy

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end 
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(email, password)
  	user = find_by_email(email)
  	if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
    	user
  	else
    	nil
  	end
  end


end