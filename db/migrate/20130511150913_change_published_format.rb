class ChangePublishedFormat < ActiveRecord::Migration
  def up
    remove_column :entries, :published
    add_column :entries, :published, :datetime
  end

  def down
  end
end
