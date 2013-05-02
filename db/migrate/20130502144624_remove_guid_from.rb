class RemoveGuidFrom < ActiveRecord::Migration
  def up
    remove_column :entries, :guid
  end

  def down
  end
end
