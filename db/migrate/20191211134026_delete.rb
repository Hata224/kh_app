# frozen_string_literal: true

class Delete < ActiveRecord::Migration[5.2]
  def down
    drop_table :posts
  end
end
