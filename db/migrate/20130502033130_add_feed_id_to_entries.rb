class AddFeedIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :feed_id, :integer
  end
end
