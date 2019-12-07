# frozen_string_literal: true

class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader
end
