# frozen_string_literal: true

class AddImageColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar, :string
  end
end
