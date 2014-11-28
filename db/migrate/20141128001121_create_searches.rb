class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :title
      t.string :director
      t.integer :duration

      t.timestamps
    end
  end
end
