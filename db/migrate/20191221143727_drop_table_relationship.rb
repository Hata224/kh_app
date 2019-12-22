# frozen_string_literal: true

class DropTableRelationship < ActiveRecord::Migration[5.2]
  def change
    drop_table :relationships
  end
end
