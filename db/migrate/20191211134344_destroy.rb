# frozen_string_literal: true

class Destroy < ActiveRecord::Migration[5.2]
  def change
    drop_table :articles
  end
end
