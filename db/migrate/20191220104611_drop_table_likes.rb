# frozen_string_literal: true

class DropTableLikes < ActiveRecord::Migration[5.2]
  def change
    drop_table :likes
  end
end
