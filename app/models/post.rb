# frozen_string_literal: true

class Post < ApplicationRecord
  acts_as_taggable
  belongs_to :user
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 1000 }
  attachment :image
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :unlikes, dependent: :destroy
  has_many :unliked_users, through: :unlikes, source: :user
end
