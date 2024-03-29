# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable

  validates :username, presence: true, length: { maximum: 50 }
  validates :profile, length: { maximum: 500 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships
  has_many :unlikes, dependent: :destroy
  has_many :unliked_posts, through: :unlikes, source: :post
  attachment :avatar

  def posts
    Post.where(user_id: id)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.username = 'ゲスト'
      user.confirmed_at = Time.now
    end
  end

  def already_favorited?(post)
    favorites.exists?(post_id: post.id)
  end

  def already_unliked?(post)
    unlikes&.exists?(post_id: post.id)
  end

  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    unfollow = following_relationships.find_by(following_id: other_user.id)
    unfollow.destroy
  end
end
