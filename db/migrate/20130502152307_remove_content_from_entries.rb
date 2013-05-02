class RemoveContentFromEntries < ActiveRecord::Migration
  def up
    remove_column :entries, :summary
    remove_column :entries, :content
    add_column :entries, :summary, :text
    add_column :entries, :content, :text
  end

  def down
  end
end
