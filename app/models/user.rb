class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  #      :token_authenticatable,
  #      :encryptable,
  #      :confirmable,
  #      :lockable,
  #      :timeoutable,
  #      :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :invitable
  
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  
  
  
  has_many :projects
  
  
  
  validates_presence_of :username
  validates_format_of :username, :with => /\A[a-z0-9]+\Z/i
  
  
  
end
