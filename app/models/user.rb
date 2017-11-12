class User < ApplicationRecord
  acts_as_followable
  acts_as_follower

  acts_as_favoritor

  has_many :articles
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
