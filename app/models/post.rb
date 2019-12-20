# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  attachment :image
  has_many :comments, dependent: :destroy
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user
end
