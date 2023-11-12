# frozen_string_literal: true

# CreateBoards
class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.jsonb :grid, default: [], null: false

      t.timestamps
    end
  end
end
