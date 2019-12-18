# frozen_string_literal: true

class User < ApplicationRecord
  # mount_uploader :avatar, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable

  validates :username, presence: true
  validates :profile, length: { maximum: 200 }

  has_many :posts, dependent: :destroy

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
end
