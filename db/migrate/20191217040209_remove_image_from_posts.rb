# frozen_string_literal: true

class RemoveImageFromPosts < ActiveRecord::Migration[5.2]
  def down
    remove_column :posts, :image, :string
  end
end
