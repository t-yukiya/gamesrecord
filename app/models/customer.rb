class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  has_many :following_customers, through: :followers, source: :followed
  has_many :follower_customers, through: :followeds, source: :follower
  
def follow(customer_id)
  followers.create(followed_id: customer_id)
end

#　フォローを外すときの処理
def unfollow(customer_id)
  followers.find_by(followed_id: customer_id).destroy
end

#フォローしていればtrueを返す
def following?(customer)
  following_customers.include?(customer)
end	 
  
  
  
  validates :name, uniqueness: true
  validates :name, presence: true, length: { in: 2..20 }
         
end
