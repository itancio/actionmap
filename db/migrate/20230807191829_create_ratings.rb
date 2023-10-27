# frozen_string_literal: true

class CreateRatings < ActiveRecord::Migration[5.2]
  def up
    create_table :ratings do |t|
      t.integer :rating, null: false
      t.belongs_to :news_item, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :ratings
  end
end
