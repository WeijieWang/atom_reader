class ChangeTimeFormat < ActiveRecord::Migration
  def up
    remove_column :entries, :published
    add_column :entries, :published, :datatime
  end

  def down
  end
end
