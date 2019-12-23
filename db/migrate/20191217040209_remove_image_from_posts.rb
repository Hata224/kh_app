# frozen_string_literal: true

class RemoveImageFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :image, :string
  end
end
