class AddKeywordsToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :keywords, :string
  end
end
